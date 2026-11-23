Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795421128;
	b=nh5VckBaqSbRvHCOzo6NlC6ipy9keTpiBp7dyflJvAi/IIziWMv5TTOgEubNQFyTZ22V
	 AE+fqJEkyQ7ZRBiX0rLwrT++MxU3+0bdw090xQtFBWnSo0jfS+Tv7+kqrg8IUIYTGFnSC
	 jYkYVL2GDWKl7HZAcGtHY0ByYQa/E0xkYujFR4TC4VOi97d6i2O7CYCLdwdkA5qOMTVGV
	 jje/NXEZm404JB2hO32ivHjwZV8qCq/C1ml7+iHiFQRytr/p5Rd5sVpMCeH/+55LEDtH2
	 d+jokrRclod78D98ylhrvEm+9mr29oMDsKmSEsWPchGfnnYI0VUr9Q9vsLP9zJrfLuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421128;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=D5zFHPsxg2olUOtT71M+VzNGQXvqMhvbrtdWNmGkmCA=;
	b=TsR4bZ5yuj8V0Kfkhehha9V63j8cQ9GIraVnDRO+1SmRfPDElEyCyM3hGHg0yTP/pVLL
	 iwEamOZrjPXjMy4WBYCAoVE13AArOT8Zy/iN6uIBtp1cAHO6ocRsZXYIWCR+ouZNNOrpe
	 syFBXL2bukm8PXz4CVAdrMjGK71QrIT1iGcI0ZstuUenU+uvcP2WDdtJ+xmG5rgH4rMOD
	 mVVHSCC4GiFcsc6YG5T+kJf/C7PHj2pcIVTGBXuWu11uZdYKyQm+IaVmCZM7F0f3ylPCD
	 jDHscP75icPqIydb3R0hLpvkuU5F2uZHvyppmzIgZGJCaPs69sEtW98C3YLRgbl+YEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="ItEIU/vu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.44
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEBF606F60F
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 08:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EEBF606F60F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ItEIU/vu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcNM2CU/v6l4BasqeRYYi44Pav2RiyC+r83/oUJ69bWXDSUbASnlQNzsVc853mfZ+GHfSEk/f18mwGDhlpEuEFPuR+gZtfjUyt5QNeWCUlYepbPCdzsE4fhzihDRooDthP47cBy+/VtMIr8Af3uSAe2EBUlF/jkxo6bJg1jZlJ7t/Y+QLuKqnAYWmO0N1qGyYySuIOyxjEzD6VCSXbYC3Fo1ZcT1uB6u5WgTbBC94ckWJTo+dIsR2XmeJSdlfpmhVVxw32ML6ngU+SVMUOGC/YYBvXFoqOrthfTIA7CRYMzm2gZYp+HB6J/nPuVSH94dxvVnC/HY5YAZYb4yjQBJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5zFHPsxg2olUOtT71M+VzNGQXvqMhvbrtdWNmGkmCA=;
 b=qdSaFYqQ54PYQc21KvcGqHZRyJO4uenDJwntTeACfgNyCfX3E1KTpzjSbfA2V8EBA1yXlk9cj8Rqu9zyLuFoZCj+rcuXlQcTlZFTsLbyYHt030ZVhAKylc7i30qmjd+c+MFFevSRR1/v9yCsyeZRGV0MKOpGaI4G6qpyic3kQGwkkyCH8KQX+BYatHJvpjsfN0SIBkX0SOQvvZPmKLypKQqfezpRR7yvpJ8wa1IFIMnh+s/BGkjg3631SHR08QIFPaJ5bi1Vu3Gf7DaOtDIzmNQg51gfMhDIPM/mr3LEobJi+fDbU0UREQ0BKlMFmRMs9cryLSDSUsZKtLF5+7xuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5zFHPsxg2olUOtT71M+VzNGQXvqMhvbrtdWNmGkmCA=;
 b=ItEIU/vueJ7TlSsW0+9BIC+nrQ/TvMZOzgM4cWY0WBOIXhzC0yeRZ6m+XDUtVJIxEaqmRJ5d1eGTxxnltzf+LlBQx1bd4W1D6H1YdSexT1czrHeVw3l/2wkRNRXwL1DsnwC/L3iUUlmuqJGYBMfmuvN2gDKKSBmDDIcRKy4DrtxqYZ3uHgqSsoiAShUNJo7HfEsuIJqZv+1BvFXE3I1V5Y4AII0qcx8gY58Xkt9xsB9JmVur6rc2lleM/ZkHojoifg1h9XeIC9OuRav/o5I0WAz9kpVXMYy9jBMdfP9fevirbvxl/UXZ1nZUOw95HduDtBDD91fzTIF90ri/4rClXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by CHBPR12MB497579.namprd12.prod.outlook.com (2603:10b6:610:33d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 08:05:23 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 08:05:23 +0000
Date: Mon, 23 Nov 2026 10:05:15 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@kernel.org, willemb@google.com,
	horms@kernel.org, razor@blackwall.org, dsahern@kernel.org,
	shuah@kernel.org, bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kyuwoncho18@gmail.com
Subject: Re: [PATCH net 1/2] bridge: mcast: Fix source list rollback on
 failure
Message-ID: <20261123080515.GA3126678@shredder>
References: <20261122072504.2623702-1-idosch@nvidia.com>
 <179541888207.3135.7176816464038643772@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179541888207.3135.7176816464038643772@kernel.org>
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|CHBPR12MB497579:EE_
X-MS-Office365-Filtering-Correlation-Id: 336a6949-824a-4da8-eec6-08df4938868e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|6133799003|18002099003|22082099003|261021121427099003|261021123027099003|261026140227099003|261102123227099003|261022105027099003|261028144727099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Y+eWzZVKsHt9rRH48aD6SVppoQZmcD8zme5AkZU1F7LLg/RkxlRCjp2XZ6lOUq3l+uMgx0LBXL/WWyxUnI6imjrkVYnzFdEF/ADP6g94QzD2qm/Et7orJWpwgFLEkfBColAxpBhSV5E3IOEW3F9khU/FeaJ0pXrDxqs9Kt/+6vA1Wja6Q7l9CExs6EUwPvgCs3pCsMN0ZfKfL/phuohiBUGb/bwPlNoejqxZOZNi38KrhrUfMFmwxUS/q2m/9/eXmIccXAySBb7uFpNyhWo9eUj9FBrvaW/UkMxp7kXg0lj/TxxSJNW6WfikeZ6l/tpPP/HEMRsrrAvd9QLg7YHO6i2qgwhXWSjwH63GCL1oyjLmLIpm9E4SRc/HoB658n7HWWB8ttN5h0KUQF0YptvLRN9IU0kOJ9ZeBZEwAb6HSc0DKdzlK+wFiftEGT0E7hpUupZtryZ55djILfTiSSNaAJ5HJdlbGTF7H/Be7LlsFl0daagUypfOcDuPmnXSAA50ZbiJcz59ZkyK0dvn2BuTk09QFdvt7k7qiFIwIl3oFyIbSNiRiRX8yCc1Hicyju5JHCvQr7ZVfs+WoZNE/ANNJ7WkydhFIZHEYCHGTRXy/K2qgn58ootQ5/JRl8Xs7YM38WmMZ3UEf7ZBfy5B0FMEYsp1zi0QAZzo5rSyrxIDD2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(261021121427099003)(261021123027099003)(261026140227099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h0O/W69Aa0rVzfPsqUWgkiMNJX2H6vGdyZ0t4Kds/UCzZY0idw/2Aa1Pryas?=
 =?us-ascii?Q?ZdBQJJa0qq9wfIhEom7uMS5eIuWxHegpqO1CRlzIIFaRSg5KyFjejANVOII4?=
 =?us-ascii?Q?FqZ8UD5ZGfz/FPO4p3TtKVHwq67kG/0JOnYwuX1O5WXXMJqRio/QTsQd66WE?=
 =?us-ascii?Q?Xrq1s93XG1u7bAe+NCJYtHMhGpiDablYIxG6cdYM49Qd/BV1VXaaVIr3VxRN?=
 =?us-ascii?Q?lSCchPA5Qax8kOSWBuACT8yFlue/7OwV26XuiPLNGsm1eXV0sKI3f+z9/ybh?=
 =?us-ascii?Q?BgxMQNZel/kQOBYUhE8YtNrSdmY8CiYqGi64PQ2d5OgFeC+tZ12bs6JycAnE?=
 =?us-ascii?Q?PtfxZkTUhWq0YG+8d77qi2ns2nyK47lEoq6/XGLycLsy9bVoP5qksrWA71/7?=
 =?us-ascii?Q?rh+H1GURIHl3w4K47wLOda+t2xVka43NfT6Eo9c0W1QDKChq3aM3YQjB5Kc0?=
 =?us-ascii?Q?+uJGwE5J4Tab2LQis6uxLi3cRR6C+L83jzt9OfLegTiSYtbp+p7jHvaX3uMn?=
 =?us-ascii?Q?wChY1Ge+l0XmeXn8jnz9p9Jws4YLR5lck7RA3NPD2r77FyHZBkTb9HRu+ihk?=
 =?us-ascii?Q?agnNOAoy+rfukUJwUdrHlul07BNwukQizNRQ5KWD0wb6arrGQZWv7V3VYbIv?=
 =?us-ascii?Q?Rsn5w7aefbFk/gH7EzUXAaJLIvCZOk+NNs2QFNfmDWi0ew1fN+WUacGyis0U?=
 =?us-ascii?Q?FsXC3koHUoAJBp6fC/hJtOjs7Bj6O+C6Fn83IcnY/zKwVso4k9hZySGiFISk?=
 =?us-ascii?Q?Q1+Gvbh3vg/OGM2wE97cnCHu1UjUDQUBduSnRlcdJ+R25icEL31i6d6koz9n?=
 =?us-ascii?Q?HkGIA8VKbm0jXRF7bLbbQ+6zrnd8XYtRXVIxZNVWRU+Ce04jA9AASMHeIDaS?=
 =?us-ascii?Q?qFnkREbt+bj60uu84IUnJ4iJI35tonf8sKpa577WYpeyNOewCjCyHFVxC8zv?=
 =?us-ascii?Q?NMXZeHh/f/31T8TXgpFg/n4O93VLzgbEH6bXpYo4UBP5QY6n0erjZLCEdgfZ?=
 =?us-ascii?Q?BYcQKeZmgHHQ12IS7m1fAtIxIRmBCWydGBiZhf2jTL47IVGqoN9O0SMzRzTX?=
 =?us-ascii?Q?+VA8X+CjwvpsoYzJKTAoeNw/tujX7hE5n2/anlGmpIYcUlRR1kEN1uuiDzI3?=
 =?us-ascii?Q?Xc4Wk5ax6FS8TC6Dk7TtZQlwcN8mIFXK11fp9PlDGTn+FFiTSUpbSOw85OGT?=
 =?us-ascii?Q?7Hmd7XHbpPLdS72D4NWwq/QeEw9ecoYnf13g21L51dI8vpAlxmoXhXQY5VMt?=
 =?us-ascii?Q?OOqqZ4e71FArSgxvLrRIo3oEM4ZEx3nvzUSy0PBQiNon4O+YqAcDlCDVhdL2?=
 =?us-ascii?Q?p8uld98c/pIWbRnY17SaEpIAefOStGJ0EQ1K2PSgn9oiH1fETS/aN/SWhzht?=
 =?us-ascii?Q?hcz4TfBN/62kUyVWcERvXJd+y/U5WLNnTt8++W2OJwPUZ8Fiqw4kcLTj76HB?=
 =?us-ascii?Q?IGNv8kEzAE/kYGjl/QaeTHMbMHtVP8AIQOVfhp5KzbtZ+EPoYG7lWnRgj/2f?=
 =?us-ascii?Q?LkQXpT753vNaSySIvzcnHWcYPX9RYypVoNrCFa1VJTKzaovmLsQ+4OfnsHOC?=
 =?us-ascii?Q?fI9IbYN/8dG7zjhIUwHDo8GEblgTzX0vZNM7fDIVMRxnOToBFlvEIaTymu0A?=
 =?us-ascii?Q?0LvPM6d2lYUpe/TneFUK+fvRkGTVnCcSfVdr3HfYg1yrdfWzvHR4lqyY032r?=
 =?us-ascii?Q?Jr/1sRzNWm+MBaYXeyEdGgGDxMk/GXlZ3HlFLqjmSPFAodxy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336a6949-824a-4da8-eec6-08df4938868e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:05:23.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cxhcwszobd7j+t612PRcDIcl6ZdoA8pp7YqnjrRYtJ4thvvKClKoEN9T/jCbAkYxvGiqHbw7HmMRwlauCkftew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB497579

tl;dr - I believe the patch is fine as-is.

On Mon, Nov 23, 2026 at 07:28:02AM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> With NLM_F_REPLACE, the pre-existing sources that are now kept on failure
> were already changed by br_mdb_add_group_src() earlier in the loop. Is that
> state ever restored?

No, but before that they were deleted (and a warning was emitted when a
source was specified twice), which is worse. Making the replace fully
atomic is a much bigger change that is not suitable for net and it's not
worth the complexity given the failure is very unlikely in practice.
