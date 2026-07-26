Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105E27CCF0
	for <bridge@lists.linux.dev>; Sun, 26 Jul 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785063841; cv=fail; b=E8Sl0+xBWUtBzRumkg+f8RacL6SNJ2aFD054iLyZxj74nA4f645Nsgimu/nJ07JFEGIx+LDV5nwBBJznKeF7h065gvFXCCrY2MyVyuSIuM3nCA5/M8xWnOlaO8pXYdzFDm7+EjJZSqL2yBEni2TNn/4OiPR5HJIZaJemS5HSp0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785063841; c=relaxed/simple;
	bh=GQ7X2GduOLLq+YJDAozca+4YwOzCqqx5FG53M5cPYeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZ7OZfTSnCphXaEQcwRl4VSY6Nu2Z1G/TbErUAso4VcV2J1td75BrH/V+yw3eFvma/wiYmjPejR/hteK+I2C338ZwxovvP9jtH1mKNaaAeHck0sum9KxvL3Tpbk07LlMgSoRn7zHAnXNJLjWIHWW3H1Axj9hINpwRNRxHaNrhVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=azt//vOv; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="azt//vOv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COAAPUWg32PIScKXSDA7m/O/AjTD68NwSBiZLe0zE6zDnkTShvRt+tIG+0g7pJ0ZWxoZnVxHZlC24rNZExFPhULdxAa5vK0yzB/Omne2bYklP8PW4GMaqEt7te59i7E3lO9iPziX2VoJi4kkieDDWMqBL07lX/EM0oXdOztmJ/njzHYahNAYwdh3krWMPXdKZdkK4EbYr444N6U0/R5L9Dtbgvk0O9cWIJ/3OPovVdtyiU364n3Cs0ogpz0ahFUUFagwbEa5j8T5c9zGvv9/mdBBknDQTCfAYbMrcX903iQRGp/CJ9/JE/gY0NE7doPOpbLYvt1FOuhaLHTFZRKDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQ7X2GduOLLq+YJDAozca+4YwOzCqqx5FG53M5cPYeU=;
 b=FRXJLugMhGqeFI444vh3kMgxv+ov8YvAURiQ4p88Fh61STa+Ih4Tm7cXDRTuvmjQCQS22qAt7RMeKrdJctWvmsJBYhdhWgu+mbqJJlUuOg58lXUpV+Mc+sAfA946yL8J5I5rhZUIFRZgvwZs2VoDp71o4wvrz9zZ8xSJwAQXLEeCjtCLKCsUO1QZ/7HF0ohVJjN32m9FBfjLtOAP8Ped2AjSEujakJwBiQelM1wwhEXyO9Gv3xVcrhnUy9ewCqmSBbaHAE9BHa7QKkI1972qAukrK4W/u/LHbM6RwqPuqfVWjz1ub8nQn+jK2Sz02QdT6KHheCa0oisfkYaPfip0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQ7X2GduOLLq+YJDAozca+4YwOzCqqx5FG53M5cPYeU=;
 b=azt//vOvb31Uis10GKd6aoTKkTHvdUTkgmaWi51j+mrjBTO/TzY+0fRFQqqyjQMpmdnPGgdY8gAhjQqATR5D6Tmx1RIX1TCaJvSwjN+YyBi+1XOGXvhTh8LxgB5LkW6PRBU4ER+iU50Vvql6/zXtkj1qyFXVPO2h2W+Dn98Y7CAXCPLLS+L9S0LKeKvsLuzE7c0nLZLgVxnXH1ywVGUqcoLz07pZUQXUz8rw8kPEX54IrW5ccjZbB6yM74VWU6y06nckShZ+UhwiE9Px5TSPEHhiAy7bTNa1hOESrLizwWHcISnfYr8MQ3a93gVPhHAy0E9RoGh37oYWZT7OvbiLZQ==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 11:03:54 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 11:03:54 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "dsahern@kernel.org" <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ja@ssi.bg" <ja@ssi.bg>, Petr Machata
	<petrm@nvidia.com>, "fw@strlen.de" <fw@strlen.de>, "kuniyu@google.com"
	<kuniyu@google.com>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/5] bridge: Linearize skb once the ND message
 type is validated
Thread-Topic: [PATCH net-next 4/5] bridge: Linearize skb once the ND message
 type is validated
Thread-Index: AQHdF4OCWWSQypZIO0WqcdfI7Ctq6bZ2JIyAgASJUqA=
Date: Sun, 26 Jul 2026 11:03:54 +0000
Message-ID:
 <SJ2PR12MB9008AD38B9DA4AE6CF0A3998D8CD2@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <cover.1784463131.git.danieller@nvidia.com>
 <c431f129eb438c12ef1e48d91039e09489a8f862.1784463131.git.danieller@nvidia.com>
 <27d8e26e-3498-4741-949a-742d057bbcde@blackwall.org>
In-Reply-To: <27d8e26e-3498-4741-949a-742d057bbcde@blackwall.org>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|LV2PR12MB5848:EE_
x-ms-office365-filtering-correlation-id: 94f93f80-0636-481c-7f51-08deeb05952f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 DrEK5xRWJY+ExPagFk8OhshzAi0jF3TP1/u6OHlfOnYa4HqaTt5oErRWw77gZbcbuzQCzATQ678PweYpkvw1yHgbfX5NPLBMADEG+zpw7+rjexNCHnJYtNllT1kwnhx+BOmqqDHJ0kS/6GlQ+8GgaNYTACtkBl7ziO54pD0NunbK7JKsyTMJfcn+4N2na3iyR4S9C6BTQNevD4kUMpwnExYnb91d8y9zL4LdqM0visUH1nANWZ2T2K9a20TRV90g158O1dOceV19LL9oMJfuYCxzB01LjKEo8VKRgULYpaSaWLZ1ZinNSf9Q/aYMBEs455mdjFFpVUHfmjtLKgW7vZoffceRi8Lbz3bsF+6yEmP5DYjB5T1CGjPsmi7nN/xYdKO6It0ghTAOurjwjId2Ye0eXm5FEydCWmH+2fXiAEjuirmD4NHI2A+wuGAU3xa47j6Ml+eUmuzFX+AMHSUtJ0Xx8wIYRMyD7e0mblW85Z8MTEQKcBDuD4Gu8gE8jDHDfnaw82zp2PO4dmyjBnexGQZROsg0W8p7nRtfPbjP90BbtsOq3QKfmYIEOR+A1yP7aV6tZghQGbZsTcUzTz7ndsRM5qqZxOJ+i/LUPO/fYSSX1S6RsgXqSC8R2Li5GE7tBMvlumSObx2r/UiOJQ4ZEuxJu3lXRoVjx1B3zCNxcLc298sV/SVIogdfqHMHkwqOZUhjf6oZjxfHI53fPLB9iYYqIhNS7M0/wCCWoHvqS3k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEVRZTh4Zkh3ZWVvMGd3WFV1Njd0L1Ezc1F2b25peFBxYWtWT085bHV3emJT?=
 =?utf-8?B?MlgrNXovMGRJNnBCcElYVitBOGZxU1RINE5RbDRTamdwV0ZVM3M0b0d2VUU0?=
 =?utf-8?B?N2IyM1NuTkRBY3FMbGF1SjVnSTdWRFVDK09SVVBSY1NnTExtU29yWmRHc2Vy?=
 =?utf-8?B?R1JiZGV1N0RKaHdUdG5kcE5TdWVtY2NneXVzUllFUVprc2E4UjBrL2c3cENZ?=
 =?utf-8?B?bVNXWGU4UW5ycVBKUzI3ZStHUU41c3FCeDBFRFlYbXZkeU54QVh5QklFSW9l?=
 =?utf-8?B?UURKSTUzNDBvZDlYR2ZPbFVaN0RyTWhxdUhHUmxVWmMyUlNnL1QzZnQ1NE85?=
 =?utf-8?B?aHFFMi9PcjBkY3E5VjBwb2tMZG5KQ2xXRFFEK1ZiY1FwTi9tcUNNdDliM0Ns?=
 =?utf-8?B?aFpISnFTRVJ0dVlhc2M1b1M3L0xtSC9QaVpmbW5ZK3ZBMVhGTHZOTUhBcE94?=
 =?utf-8?B?cHV4cHBPaTcyNGlhRzZQRm5VKzhEUUdlSWNZam1vTXdnVDZZQjNWdVM4ckJU?=
 =?utf-8?B?VlhUNTZhMVFsUmN5MzVrajhhbDUvZmFZSzNvdEtTRU1YVmJHaVBER3huWnVS?=
 =?utf-8?B?TlBrYXlqVU16QzJkM1kvZ0pRSEQ5T2hjaDlINHVvdDgxT3ljb2twVHNjZEFO?=
 =?utf-8?B?QnFjRm9uT0Nrb3dLem1yNGhTOUV2WEU1SXBySyt6Rm5pRDMvY2h4RVpnQnBE?=
 =?utf-8?B?WHduYXlvUXdyNGpDQkhIeW4yL3pmY0Y4Mkd4OTI3ZktEeGdTb1lHWWo5cmR6?=
 =?utf-8?B?QXliOUJLOFFtdUk0WXNpQkxqLysxWkg0MUNmeHdDd1BVRkFOck4zY0ZFRXpv?=
 =?utf-8?B?WjBXM3ZPdk9lYW1qNjNyRThNb3EvUXROWUdsL1ZCTitOK1lDcU0rUnBxaDJn?=
 =?utf-8?B?WTBmZTVRTW85YUJDcWxOSFBoQlNFaDkwZVFzK0FSbU1uQzNxZ3c1d2N6SGV4?=
 =?utf-8?B?VEZOWWJuTERoc3lDYVQraWJuYURIcW9UbXdUdngrR0VKMHMrS3ZGbmttZUxK?=
 =?utf-8?B?UC9RTDREem9EdmV2TDQyWE1iNmtNSkNPV1c1N0J3OGU1WGI3UXcrcGRWUFFU?=
 =?utf-8?B?Y1l0ZEY5cHczSWVEMEtDV0lRcmFSUS93STJFcWZVQi9UalQzT1BFSkVTT0lE?=
 =?utf-8?B?MmFUZGNoQ0JFUWpFOWtieXN4KzRFRFBFSzhWVTJqdTgxSGwvcGNsY2FkMzEz?=
 =?utf-8?B?TW9OVUpoeXRVVzlPWXdoeWh0U052ZWQ3NFh3c283UFh1Y3IvbDgrcnNUd00v?=
 =?utf-8?B?ZVllM1F5MXZVLzVlRUFCVGRNNncxTFc5Qk01T3pBSnB0c2FGNGR6SE83MEVp?=
 =?utf-8?B?RWcwTjNObE9oMW9jVmlNOFVOc2VkUmFVZk5lNnllSmNDS2RpZ3Y4RFRlRURV?=
 =?utf-8?B?ZnVuc0ROWTRFNXNCRUJNYlBoRE56QmdXZ0lNcFF1enVnMTlkeW9kckozdmpE?=
 =?utf-8?B?OE9rcUhlVkQxS3hkemduMGFIYkVNbCtBTGlPeWNUMzRudFhwUDRQSUl3MWY1?=
 =?utf-8?B?dXVNYSs1dGlweWZWbnNrZEpFdzB4ZjVIVUQ2bTBrTk53OXYvVHpiTTluTjVR?=
 =?utf-8?B?SVNmbkx2Y2FXQmVETHlMMWFjVm81YkNuV3llbWxnNUx6SkJPakZmT0NBeDdH?=
 =?utf-8?B?bjFOaEt3ZVVNQTI4RERBQ3QxZit2L1RQQXZadE4yd0Z3aGttNm1PNGpuY2h0?=
 =?utf-8?B?bDQ2NmFmNk55NjRrakVSNGRvN3VzbUQwT2tVZ3hSWlkxRGJoTFEwT2RzQ2I4?=
 =?utf-8?B?Z01hbFY1MmxUL2JIVnhNcWtBL3RhL0dnV1dlNUQ0ZUFhN3lwb251bEs4RnRJ?=
 =?utf-8?B?NnNqZDF4ajNjaHBZVXVwYmJwTW11VW5wWnRTWjdya0JXa2RDQ3IyN1Zkd205?=
 =?utf-8?B?Q0hYcm1kYk9FYWtvZFV0ZHhVcTRIcGNnYlRhWmF4M3pZSlJiQzA5ZDE4TnlK?=
 =?utf-8?B?TENNVGFRNFJSbVpjVEFsdUZJamtqbWxFY3R5SzkzckZHYUxjbE9TVXpJNHRD?=
 =?utf-8?B?THdCS3A5WC8rRFp1U3QyNXN3ZHAveFp0Ri91SmdwSjJGamgxVHVwZmN1em41?=
 =?utf-8?B?dk5JWXR3KzliN3NIT1ZZZXFYalFHVGpPWTJWN3R2V1FmYXJkekxKLzgyYnZL?=
 =?utf-8?B?cS9UTnRrNVhqbFhUemlxUnV1NW1YeHhWUHRHTDFGbFVoUTFVeDFpODFhTGZD?=
 =?utf-8?B?WExLdDVUU3ppMzBtWGFMNElmQzh1eUpHT095dURFbENFemlhdTh2L0xkbVBn?=
 =?utf-8?B?UXhldXVCSTJXNDJGUUVrdk85eWFmY0tlblZmbS9HRC9RL3FEQ2RiS1FtT09p?=
 =?utf-8?Q?oWKGiAM0o+Pb+v0JLV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f93f80-0636-481c-7f51-08deeb05952f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2026 11:03:54.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5FOSUcY75BFnuL6cdxts++4Xp8+xBU+Y8p6J+PWj/wp675/+13HYnd/q36+rspw+atSeWJWme3y2qOK4/j9yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEFsZWtzYW5kcm92
IDxyYXpvckBibGFja3dhbGwub3JnPg0KPiBTZW50OiBNb25kYXksIDIwIEp1bHkgMjAyNiAxMjoy
Ng0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRzYWhlcm5Aa2VybmVsLm9yZzsgSWRvIFNjaGltbWVsIDxp
ZG9zY2hAbnZpZGlhLmNvbT47DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2ds
ZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGhvcm1zQGtlcm5l
bC5vcmc7IGphQHNzaS5iZzsgUGV0ciBNYWNoYXRhDQo+IDxwZXRybUBudmlkaWEuY29tPjsgZndA
c3RybGVuLmRlOyBrdW5peXVAZ29vZ2xlLmNvbTsNCj4gYnJpZGdlQGxpc3RzLmxpbnV4LmRldjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1u
ZXh0IDQvNV0gYnJpZGdlOiBMaW5lYXJpemUgc2tiIG9uY2UgdGhlIE5EIG1lc3NhZ2UNCj4gdHlw
ZSBpcyB2YWxpZGF0ZWQNCj4gDQo+IE9uIDE5LzA3LzIwMjYgMTY6MzQsIERhbmllbGxlIFJhdHNv
biB3cm90ZToNCj4gPiBicl9uZF9zZW5kKCkgcGFyc2VzIE5EIG9wdGlvbnMgZnJvbSBucy0+b3B0
W10gYW5kIHRoZXJlZm9yZSBuZWVkcyB0aGUNCj4gPiBza2IgdG8gYmUgbGluZWFyLiBDb21taXQg
YTAxYWVlN2NhZmM1ICgiYnJpZGdlOiBicl9uZF9zZW5kOiBsaW5lYXJpemUNCj4gPiBza2IgYmVm
b3JlIHBhcnNpbmcgTkQgb3B0aW9ucyIpIGVuc3VyZWQgdGhhdCBieSBsaW5lYXJpemluZyBpbnNp
ZGUNCj4gPiBicl9uZF9zZW5kKCkgaXRzZWxmLg0KPiA+DQo+ID4gTW92ZSB0aGUgbGluZWFyaXph
dGlvbiB1cCBpbnRvIGJyX2lzX25kX25laWdoX21zZygpLCByaWdodCBhZnRlcg0KPiA+IG5kaXNj
X2NoZWNrX25zX25hKCkgaGFzIHZhbGlkYXRlZCB0aGUgbWVzc2FnZSBhcyBhbiBOUy9OQS4gVGhp
cyBtYWtlcw0KPiA+IGEgbGluZWFyIGJ1ZmZlciBhIHByb3BlcnR5IG9mIGV2ZXJ5IHJlY29nbml6
ZWQgTkQgbWVzc2FnZSwgc28gdGhhdA0KPiA+IHRoaXMgYW5kIGFueSBmdXR1cmUgTkQgbWVzc2Fn
ZSBoYW5kbGluZyBvcGVyYXRlIG9uIGEgbGluZWFyIHNrYiBhbmQNCj4gPiBjYW5ub3QgcmVpbnRy
b2R1Y2UgdGhhdCBjbGFzcyBvZiBidWcgYnkgZm9yZ2V0dGluZyB0byBsaW5lYXJpemUuDQo+ID4N
Cj4gPiBTaW5jZSB0aGUgc2tiIGlzIG5vdyBsaW5lYXIgYnkgdGhlIHRpbWUgYnJfbmRfc2VuZCgp
IHJ1bnMsIGRyb3AgdGhlDQo+ID4gbGluZWFyaXphdGlvbiB0aGVyZSBhbmQgZGVyaXZlIG5zIGZy
b20gdGhlIHRyYW5zcG9ydCBoZWFkZXIgc2V0IGJ5DQo+ID4gbmRpc2NfY2hlY2tfbnNfbmEoKSwg
aW5zdGVhZCBvZiByZWNvbXB1dGluZyBpdCBmcm9tIHRoZSBuZXR3b3JrIGhlYWRlci4NCj4gPg0K
PiA+IElmIGxpbmVhcml6YXRpb24gZmFpbHMgdW5kZXIgbWVtb3J5IHByZXNzdXJlLCBicl9pc19u
ZF9uZWlnaF9tc2coKQ0KPiA+IHJldHVybnMgTlVMTCBhbmQgdGhlIHBhY2tldCBmYWxscyBiYWNr
IHRvIG5vcm1hbCBmb3J3YXJkaW5nIHJhdGhlcg0KPiA+IHRoYW4gYmVpbmcgc3VwcHJlc3NlZC4N
Cj4gPg0KPiA+IFJldmlld2VkLWJ5OiBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIG5ldC9icmlkZ2UvYnJfYXJwX25kX3Byb3h5LmMgfCA4ICsrKysrLS0t
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9icmlkZ2UvYnJfYXJwX25kX3Byb3h5LmMNCj4gPiBi
L25ldC9icmlkZ2UvYnJfYXJwX25kX3Byb3h5LmMgaW5kZXggNDQ1YzkzMGVkNTliLi40Njc3OWQ5
ZmFkNjENCj4gMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2JyaWRnZS9icl9hcnBfbmRfcHJveHkuYw0K
PiA+ICsrKyBiL25ldC9icmlkZ2UvYnJfYXJwX25kX3Byb3h5LmMNCj4gPiBAQCAtMjQwLDYgKzI0
MCw5IEBAIHN0cnVjdCBuZF9tc2cgKmJyX2lzX25kX25laWdoX21zZyhzdHJ1Y3Qgc2tfYnVmZg0K
PiAqc2tiKQ0KPiA+ICAgCWlmIChuZGlzY19jaGVja19uc19uYShza2IpKQ0KPiA+ICAgCQlyZXR1
cm4gTlVMTDsNCj4gPg0KPiA+ICsJaWYgKHNrYl9saW5lYXJpemUoc2tiKSkNCj4gPiArCQlyZXR1
cm4gTlVMTDsNCj4gPiArDQo+ID4gICAJcmV0dXJuIChzdHJ1Y3QgbmRfbXNnICopc2tiX3RyYW5z
cG9ydF9oZWFkZXIoc2tiKTsNCj4gPiAgIH0NCj4gDQo+IFRoaXMgb25lIGlzIGEgYml0IHdlaXJk
IC0gSSB3b3VsZG4ndCBleHBlY3QgdGhlIGNoZWNrIGFuZCB2YWxpZGF0aW9uIHRvIGFsc28NCj4g
bGluZWFyaXplIHRoZSBza2IuIEknZCByZW5hbWUgdGhpcyBoZWxwZXIgdG8gc2hvdyB0aGF0IGl0
IGFsc28gbGluZWFyaXplcyB0aGUgc2tiLg0KPiBPdGhlciB0aGFuIHRoYXQgdGhlIHBhdGNoIGxv
b2tzIGdvb2QuDQoNCkkgYWdyZWUgaXQncyBub3Qgb2J2aW91cyBmcm9tIHRoZSBuYW1lLiBCdXQs
IEkgdGhpbmsgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGFkZCBhIHNob3J0IGNvbW1lbnQgdGhhbiBy
ZW5hbWUuDQpUaGUgbmFtZSBjYXB0dXJlcyB0aGUgaW50ZW50LCB3aGlsZSBsaW5lYXJpemluZyBp
cyBqdXN0IHByZXAgZm9yIHRoZSBvcHRpb24gcGFyc2luZyBpbiBicl9uZF9zZW5kKCkuDQpUaGlz
IGFsc28gZm9sbG93cyBpcHY2X21jX2NoZWNrX21sZCgpLCB3aGljaCBpcyBhbHNvIGEgImNoZWNr
IiB0aGF0IHNldHMgdGhlIHRyYW5zcG9ydCBoZWFkZXIgYW5kIGRvY3VtZW50cyBpdHMgc2tiIHNp
ZGUgZWZmZWN0cyBpbiB0ZXh0IHJhdGhlciB0aGFuIHRoZSBuYW1lLg0KDQpObyBvdGhlciBmdW5j
dGlvbiBoZXJlIGhhcyBhIGtkb2MsIHNvIEknZCBrZWVwIGl0IGEgcGxhaW4gY29tbWVudDoNCg0K
LyogVmFsaWRhdGUgc2tiIGFzIGFuIE5TL05BIGFuZCBsaW5lYXJpemUgaXQgZm9yIGJyX25kX3Nl
bmQoKSdzIE5EDQogICogb3B0aW9uIHBhcnNpbmc7IHJldHVybnMgdGhlIG5kX21zZywgb3IgTlVM
TCBvbiBmYWlsdXJlLg0KICAqLw0KICANCldvdWxkIHRoYXQgd29yaywgb3IgZG8geW91IGZlZWwg
c3Ryb25nbHkgYWJvdXQgdGhlIHJlbmFtZT8NCg0KPiANCj4gPg0KPiA+IEBAIC0yNTksNyArMjYy
LDcgQEAgc3RhdGljIHZvaWQgYnJfbmRfc2VuZChzdHJ1Y3QgbmV0X2JyaWRnZSAqYnIsIHN0cnVj
dA0KPiBuZXRfYnJpZGdlX3BvcnQgKnAsDQo+ID4gICAJYm9vbCBkYWQ7DQo+ID4gICAJdTE2IHB2
aWQ7DQo+ID4NCj4gPiAtCWlmICghZGV2IHx8IHNrYl9saW5lYXJpemUocmVxdWVzdCkpDQo+ID4g
KwlpZiAoIWRldikNCj4gPiAgIAkJcmV0dXJuOw0KPiA+DQo+ID4gICAJbGVuID0gTExfUkVTRVJW
RURfU1BBQ0UoZGV2KSArIHNpemVvZihzdHJ1Y3QgaXB2NmhkcikgKyBAQCAtMjc2LDgNCj4gPiAr
Mjc5LDcgQEAgc3RhdGljIHZvaWQgYnJfbmRfc2VuZChzdHJ1Y3QgbmV0X2JyaWRnZSAqYnIsIHN0
cnVjdA0KPiBuZXRfYnJpZGdlX3BvcnQgKnAsDQo+ID4gICAJc2tiX3NldF9tYWNfaGVhZGVyKHJl
cGx5LCAwKTsNCj4gPg0KPiA+ICAgCWRhZGRyID0gZXRoX2hkcihyZXF1ZXN0KS0+aF9zb3VyY2U7
DQo+ID4gLQlucyA9IChzdHJ1Y3QgbmRfbXNnICopKHNrYl9uZXR3b3JrX2hlYWRlcihyZXF1ZXN0
KSArDQo+ID4gLQkJCSAgICAgICBzaXplb2Yoc3RydWN0IGlwdjZoZHIpKTsNCj4gPiArCW5zID0g
KHN0cnVjdCBuZF9tc2cgKilza2JfdHJhbnNwb3J0X2hlYWRlcihyZXF1ZXN0KTsNCj4gPg0KPiA+
ICAgCS8qIERvIHdlIG5lZWQgb3B0aW9uIHByb2Nlc3NpbmcgPyAqLw0KPiA+ICAgCW5zX29sZW4g
PSByZXF1ZXN0LT5sZW4gLSAoc2tiX25ldHdvcmtfb2Zmc2V0KHJlcXVlc3QpICsNCg0K
