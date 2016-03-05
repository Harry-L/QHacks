using System;

partial class AccountFile
{
	private string QrGenerator (string distinctAccount)
	{
		string key= "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" + distinctAccount;
		return key;
	}

	private string QrGenerator()
	{
		Random random = new Random();
		string key = random.Next(1,999999).ToString();
		return "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" + key;
	}

}