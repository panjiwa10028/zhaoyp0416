package com.allennb.common;

public class RandomUtil {

	public static int getRandomNumber(int minNumber, int maxNumber) {
		double a = Math.random() * 10;
		a = Math.ceil(a);
		int randomNum = new Double(a).intValue();
//		System.out.println(randomNum);	
		return randomNum;
	}
	
	public static int getRandomNumber(int maxNumber) {
		double a = Math.random() * maxNumber;
		a = Math.ceil(a);
		int randomNum = new Double(a).intValue();
//		System.out.println(randomNum);	
		return randomNum;
	}
	
	public static void main(String[] args) {
		RandomUtil.getRandomNumber(10);
	}
}
