package com.yeps.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.stereotype.Service;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

@Service
public class S3Connection {
	private final String _TAG = getClass().getSimpleName();
	private static S3Connection This;

	private S3Connection() {
	}

	public static S3Connection getInstance() {
		if (This == null) {
			synchronized (S3Connection.class) {
				if (This == null) {
					This = new S3Connection();
					This.connect();
				}
			}
		}
		return This;
	}

	private final String accessKey = "AKIAJNZIUGXXPSLVYE6A", secretKey = "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";
	private AmazonS3Client s3Client;

	public void connect() {
		AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
		s3Client = new AmazonS3Client(credentials);
	}

	/**
	 * 이걸로 써라ㅋㅋㅋ 비동기 말고 동기식으로 할라면 쓰레드만 없애면 됨.
	 * 
	 * @param bucket
	 *            버킷 이름
	 * @param key
	 *            폴더/파일이름 이렇게 해서 올리면 폴더 자동으로 생김
	 * @param file
	 *            니가 올릴 파일
	 * @param contentType
	 *            콘텐트 타입인데
	 *            https://s3browser.com/features-content-mime-types-editor.aspx 여기
	 *            나와있다. 콘텐트 타입에 jpg 올릴라면 "image/jpeg" 이런식으로 넣으면 된다.
	 */
	public void putObjectAsync(String bucket, String key, File file, String contentType) {
		try {
			InputStream input = new FileInputStream(file);
			putObjectSync(bucket, key, input, (int) file.length(), contentType);
			input.close();
			file.delete();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("오류");
		}
	}

	public void putObject(String bucket, String key, byte[] data, String contentType) {
		InputStream input = new ByteArrayInputStream(data);
		putObjectAsync(bucket, key, input, data.length, contentType);
	}

	public void putObjectAsync(final String bucket, final String key, final InputStream stream, final int size,
			final String contentType) {
		putObjectSync(bucket, key, stream, size, contentType);
	}

	private void putObjectSync(String bucket, String key, InputStream stream, int size, String contentType) {
		ObjectMetadata meta = new ObjectMetadata();
		meta.setContentLength(size);
		meta.setContentType(contentType);
		PutObjectRequest request = new PutObjectRequest(bucket, key, stream, meta);
		request.setCannedAcl(CannedAccessControlList.PublicRead);
		s3Client.putObject(request);
	}

	public void deleteObject(String bucketSrc, String srcKey) {
		s3Client.deleteObject(new DeleteObjectRequest(bucketSrc, srcKey));
	}

	public InputStream getObjectStream(String bucket, String key) {
		return s3Client.getObject(new GetObjectRequest(bucket, key)).getObjectContent();
	}
}