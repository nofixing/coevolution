package kr.coevolution.vr.comm.util;

import org.apache.tomcat.util.codec.binary.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SecureUtils {
    static Cipher cipher;
    private static Key keySpec;
    private static String key = "1a3b5c7d9e!@#$%^";

    public static String getSecurePassword(String password) {

        String generatedPassword = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(getSalt());
            byte[] bytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            generatedPassword = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return generatedPassword;
    }

    private static byte[] getSalt() {

        byte[] salt = null;

        try {
            byte[] keyBytes = new byte[16];
            salt = key.getBytes("UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return salt;
    }

    // 암호화
    public static String encrypt(String str) {
        String enStr = "";

        try {
            setKey();

            Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
            c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(key.getBytes()));

            byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
            enStr = new String(Base64.encodeBase64(encrypted));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return enStr;
    }

    //복호화
    public static String decrypt(String str) {

        String decStr = "";
        try {
            setKey();

            Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
            c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(key.getBytes("UTF-8")));

            byte[] byteStr = Base64.decodeBase64(str.getBytes());

            decStr = new String(c.doFinal(byteStr),"UTF-8");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return decStr;
    }

    private static void setKey() {

        try {
            byte[] keyBytes = new byte[16];
            byte[] b = key.getBytes("UTF-8");
            int len = b.length;
            if (len > keyBytes.length) {
                len = keyBytes.length;
            }
            System.arraycopy(b, 0, keyBytes, 0, len);
            SecretKeySpec keySp = new SecretKeySpec(keyBytes, "AES");

            keySpec = keySp;

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
