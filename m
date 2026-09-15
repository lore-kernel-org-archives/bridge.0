Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318603B8130
	for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477636; cv=fail; b=SOzaWjbqlqe5rsjPyE9fwXGbbiTUqYvlH4e1kXbmrpUd/3yMNzyzxlwkRIc1BFnt7uwL/iFMxnO/IDGdM7y7ZRR7rkp235ByRfomtAxgPRZJOdXRCVlRt5eSuQ6hcixbGr0MP1ZQ+YEWzj4UHb5FeUvfcQOULJHFGK8KtIqcxkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477636; c=relaxed/simple;
	bh=BlaNg20Zmz0JOjJ2kVCN8MNa6nz5+ZVnjEtzuNwEy3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UfTiumKdYqGHXXKlW940JznQaLeCHzOblKrh+VCsqRhR3MOVLaI5g9V6TFebWLdhQbsm2NyNIAhCdNEyTOn6G3hKU0F/Waet2IM4dhTGQdcilov1pKd11QpYOYLYssb4hkwOAcknkl4mYiIsNriQ0ckpNp50eP6BYRqjZtCxFSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gk4qtOQQ; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gk4qtOQQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8v+mfBBfBspcwQQpAbivrluEok5RNDd/BaZu8UzqsqndXiEPYkEcwCY3lbLKk27p1hCnFg+vQ6rMcI8YejQpq43GD9Kw4pmXNp33u6q33INZ/nyZCS+Zj+mum48O1jVSDfaD+CydKmwVc5xI5IlexIaNd8GE7lJdG7m6ZTWvYFrJ1Hi2N/sl5rHTRw4B2/TfR8y+PglGotacEk/6YoFxolxs/M7voAOI31Rv2qMOPODi0dyurKiNA++H6mywusudI+I/zKWSRjqeWrKr6wozAQGokJni3+g+EdTRNE7/YC2xnR2grJXrs1NrbB1F76NbljQniqYozN6LP2ClP8T+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr/SGTleog2qhtB+B+vd6Dh7ez3FxuBsUEAnbdAVFss=;
 b=TfHsAx0wpSz76Uc2Jfm2QLoIb16kaB7zBvrt/Hp6t+eAWl/8D3rqSiOhWmHH6wXLPzvltl1RmXSUIhOREeQ7Zr1SA8KK5ofv0mwr7i53y4UX8oxk3K7P7Ivpcpt4yYgg6ejC+jKHQT4KHfVhubP/Emut9b1JOpe0BEdql1bTIAVi2yrZ2+q2cSznUKQKXuOAfckiM697KSKt3+RKv0XAua1RkzQbSucoSU/ytHC8jxBSXIilHfCalRllLgNYtc1Vw4ik8OvqtYqTzeJSIjTt/k/Bc7murMWRBsWHGBt97oz2+EeeoGRLpy96dAcikpYQCernFfNeKyMblvKwhvP6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr/SGTleog2qhtB+B+vd6Dh7ez3FxuBsUEAnbdAVFss=;
 b=Gk4qtOQQ9mV8XEqeVYgpo7rF8fbiQxQrWVdIMNBDiVkUIaQNKtmnzj10TnvS2bPsn2D8psQwa8UYnEnW8GDx/1323jLbrjtHIdhSTMJx6hJnIRXtf7rKdkI8/ak3pw6GmdF5WNOYydXp6rZ9INwJXMqSzJYKP8U5AOxJnad3hiBG6yiZQquIOg/kXgk7U+5iOxKUDudp7fsOKf7eeOC9PhEJSoGfOAlI3dC0aO4nkbGb1X68C01uxeM5ioZcdw8owY7YtZaTYtGXhGMFjmyPTy/S8HYl2SRduE/liWvqpcciXWNydihISWfyI4BlhX42rCILFZ7tLwFw5DhlYO3OEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS2PR12MB911612.namprd12.prod.outlook.com (2603:10b6:8:405::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 13:07:11 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:07:11 +0000
Date: Tue, 15 Sep 2026 16:07:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: =?utf-8?B?0JDQu9C10LrRgdC10Lk=?= <ioctl@ya.ru>
Cc: razor@blackwall.org, bridge@lists.linux.dev
Subject: Re: [PATCH bridge] Allow MSTI 0 state setting the same way as
 non-zero MSTI
Message-ID: <20260915130701.GA656073@shredder>
References: <4150481789460597@ddf99c15-6b70-4f37-97c6-5b57e045b15b>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4150481789460597@ddf99c15-6b70-4f37-97c6-5b57e045b15b>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS2PR12MB911612:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e532d1a-4fb3-4aa5-c787-08df132a412d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	W2d/8yz+K3lIh0BSHJ7jnMMjpdeDrJdJC8TVzPRl2Uvbc2f3torgesGijelZm79YvcvwEq4qTh4MYtnl9icwkcs/qosKCOBHOaBbV2uFPSJzyP02lFprl69QGdhxVfPJLPW9b6XoeefIraG6YUfnEbDlRS4CFxrQx577qnus8CG9DSVzFBGFRPF46fBggc2d/s7FCCwOnCRqSwUADy3rKcTzGAtoUp8afp+CcDzwnqZD3ayyCSVgzSzxs/b1IAd8WQ9CwAgCOnhdV8C5ZeonYP4vy1zsjNu3AJw9MU3Wulm98wCxxlXOAKXopn+T5VgwOs68aGTKk9Jp8/m3c6TcmoOUwoSBb9QX13FCrelXR9db3QRpX6ANELq6LMyd7fFqZFU5JRtxvJVMKeaQOpUmF+o2teeEnbFAbOEZeHUbs++Qj9sItjtrLbvBGqBsgTP1OBZrBlwbs9rhjdjlvDvww5LWna3mqCS18DMsfns0EY8jFl3PIbz6MSlhmPsQeFmUPy91nIX98hf5MBEkjFe/w1XSARduy5cCJh3Zxy6LmDs+IY1ty0TwJTEajFeyeigI0JZ9HJpltL16/WJEaCpRxBh4j2k80lryP7Wh5KNb0D7+wgJf1RHuWitOzkisweW2CSpW9njFzqg+SV3oii6viB0HJI7KgyClHMlxftUwnps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkNhYm1pbHpncUZTY1JzdnY0ZVFPRGp3ZFRyNkkxSENidm85b2ZWNWpyYThw?=
 =?utf-8?B?bjZ4L2xmT0xBN3U5MFVCeWRWYzkvTlFzODdHQzJ4anJhR3d6Ry92MXJlc0Uv?=
 =?utf-8?B?SG8wQnRjY2NxMHZLWU16L1dFaXg4OW5sR01mWmJvQUZyZ1lLcTBHaGZwNjRG?=
 =?utf-8?B?RDNpcG5Zd0lrM1FJOVpHeEFhNWNaeHVhYkxmMUJya0Fmc1Zqck40Q0JHQ2p3?=
 =?utf-8?B?VG4rbFhRMHJnTTlYMExDN0craFV4K2w2SmYvV2o0SERodURrUVVobWtaR0lT?=
 =?utf-8?B?R3FlUUxQaGRHaWQ2QmtGcG0rZVlTekc2VitQaEtROFZOUW9FWXoxOU5xMEpy?=
 =?utf-8?B?UHZ4Z2U0ckNuYWNPekRIQ0F0Y2NqS1pwUVhqZFZ4dTF6ZDF1UVNqNWVCSGdj?=
 =?utf-8?B?WmM4bkI4bU1YZmtxM24weVJQZjZHVWl6NTNDdllnRTkvMkFmSzJwbDg4RllO?=
 =?utf-8?B?QUJRQ3lCK3U3eXJFcmJzaW5kUS9LQVM5TmRJQ25uaXJtMmRwS0tyUWZRM3Ix?=
 =?utf-8?B?M1JuWTRTSm44SlU3a1pFdjRrTDRtaVR6SUEwd1AvMnh1ck4xV2RDbzRxTGM1?=
 =?utf-8?B?NmN2VjdTcWdQNlhmV1lsQnc0blZJTEJuYTVsNysvNUlWMnMzOVZRRXREVk1k?=
 =?utf-8?B?QmtGNDJQZEtUZFFCbzY1UDduQU1CQmh3TFhVK2FwWW9sWDZzK1Z1OEpxczdX?=
 =?utf-8?B?dzlLcVhIdy9JRjdYTmlQU25DTEdoK0FJWWJ2RVRmLzR6ZnYxVXZEQmNwNUc3?=
 =?utf-8?B?UHRQU2FPVHpla25NejFhRFRCQzFKYkw3L2RMeGFjS2wwbUttUHdEMU5vb2tR?=
 =?utf-8?B?SkRFV3RiT25xOVRqdUVQbmZNOTJzNUpKV3lZS1E2UHVna0VjYXdHSmR5UUo5?=
 =?utf-8?B?eExsUWdnQ2VHSVlGSkszbjkrZ3d1OXhKNXlza1NoWFhCb1dHQTBpTnhvTVQr?=
 =?utf-8?B?T0dWWUhjSDVyMkppRkVoRlNDQkdFcUJoRzhaWmxDakNmZW9oeXp6aG83TzVw?=
 =?utf-8?B?NGpUdG0xYXZRSUxSK2c2VFZQRVBVWDNKL2VzOFdDUWE4UW1Vd1E1bGdVYTVu?=
 =?utf-8?B?UmZQRVE3WFJNNnpFeUdJb0lDREt6MUhXL2ZUZEJabWpPNVFYdFRmTTI1SEpK?=
 =?utf-8?B?QnVvelVPZEhsdy9iNTFYdUl5WDVsQ2FXbTZTeEphalJqSi9zZHcrQkllTXJC?=
 =?utf-8?B?ZDBJc2tMMlNWWmdWSDR3MzZPT0NoNnp3VzU4czVmZ2pSR29sdVlSQjVNd3Z4?=
 =?utf-8?B?ZkJoUFRadE9HYXFBSThlUWlNdHl5Z1RYKzhtemZMbVNBeVphbXIwbDdYZGxk?=
 =?utf-8?B?WGlKcWxscVM2WTRNcFl6S1NyU3QrcEd1aXRPQXppTDBvUGc0enMvazBFVkdn?=
 =?utf-8?B?UjYvU2d5Zm1xaGlHV3hVV3U1Q3VZbnJCSkdnUWlpVGdBOTI2UnNZQmtCVkN0?=
 =?utf-8?B?UjBENFBhbjFTYnhUVkFpbHc4NGRsVitFTkdqTWtMZ2NxSFRPRG1VR21wM1RK?=
 =?utf-8?B?dDduZEpRTjl6dkNENUhpY21pMHdiME45VFpnZU5vRmJmWFJWY29odmVZb05C?=
 =?utf-8?B?Y3hXOGJmNjRmZC9kL1V0bHZ2VlVFR2pteEduelhGREpvWTR3aGErVmNJUDZh?=
 =?utf-8?B?MGJIcnlvNDJETzZhZUZUUERyWE4wcWdmWEN3akx4VHJHQkR3MFB2OXFrSjRF?=
 =?utf-8?B?WTVuYlpraHpnRkc3QVFqY2xUMkt6QS9pbkQ2dStsTzhHL3BnVGVGcjl5eDJk?=
 =?utf-8?B?enVEVzZXelBQYUNPZm14OVdtYWF1aGNaKzdpekVUd1lyeEtLVGdCTk9aNE1R?=
 =?utf-8?B?Qm5vdlhCd3JiRllwY0loZjN1enJSUlF6TUNKVEttSEVWR1dvQzA5RGExMW00?=
 =?utf-8?B?MjFZWlVaZndyVm5La1VDUlhteFN2NlhydkxEenRIMlhHeXNON3d5OWdIRjVk?=
 =?utf-8?B?QWc5NmZOT1Q0SkRCQTUrZEt0amxkMWVBNVhaSy9nU0MvZWNsdEo2a2NzTHps?=
 =?utf-8?B?R0U2WHlOeGkvb1lodWs5UG5xcWtWZWd5M1RQSWhYNmRlajdTNVIydFdIeGpl?=
 =?utf-8?B?MmZMam0yeXdGMkltbmxzWHhTV3pSczdHOU43RDlQa0xndlNLRXVxc2F3dGRZ?=
 =?utf-8?B?emYyYTZMclV5Q1ZCaW9ZcVdxQVNTS0pMQnJNODZ6Q2JLa3RYRkIzb3lFcjFI?=
 =?utf-8?B?QXowaG5VcTlmRGxDUDBtQ3laRTgrOGN3c2JhVkpWVlkxOFZ5ZFJqMWQwWGdH?=
 =?utf-8?B?cHkzQnFxMnlPSXYwZ1dJdEhXbDIwNnlXZ0JTb0Zpb2JwdE5tMTAxczFEdi92?=
 =?utf-8?B?UVRRcDEwb241aUdrZHQ1aVJZdk43YlJsa2NnUS9NUElaNDAwejZEZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e532d1a-4fb3-4aa5-c787-08df132a412d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:07:11.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6HZe/7/yoN+VNO7GJPT6OdvYo+2OJO4pBBDZ7nlpgNQpfNucNXd/Oi5FkkgYpdxB5L1YLe2nw4USKVAv4HWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB911612

On Tue, Sep 15, 2026 at 11:23:17AM +0300, Алексей wrote:
> Hello!
> 
> For now kernel rejects setting MSTI 0 instance state in the same way as another instances.
> I.e. any non-zero instance state can be set with the following command:
> # bridge mst set dev <dev> msti <instance> state <state>
> 
> While MST 0 instance state cannot be set in the same way and requires another command:
> # bridge link set dev <dev> state <state>
> 
> This look a little bit inconsistent.
> The following change fixes it:
> 
> ---
> Allow setting the MSTI 0 state the same way as non-zero MSTI.
> 
> Signed-off-by: Aleksey S. Kazantsev <ioctl@yandex.ru>
> 
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 43a300ae6bfa..852e21b88c69 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -112,14 +112,12 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
>         if (!vg)
>                 goto out;
> 
> -       /* MSTI 0 (CST) state changes are notified via the regular
> +       /* MSTI 0 (CST) state changes are also can be notified via the regular
>          * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
>          */
> -       if (msti) {
> -               err = switchdev_port_attr_set(p->dev, &attr, extack);
> -               if (err && err != -EOPNOTSUPP)
> -                       goto out;
> -       }
> +       err = switchdev_port_attr_set(p->dev, &attr, extack);
> +       if (err && err != -EOPNOTSUPP)
> +               goto out;

1. This is going to conflict with:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=18a6fe05fb6e18de29fa90d388bb34044114b3d8

2. switchdev_port_attr_set() can block and msti 0 can be set from
softIRQ context, so you will get sleeping in an atomic context splat.

3. This is not how a patch is supposed to be submitted. Please refer to
the kernel docs regarding this and look at other bridge patches for
reference.

The code seems fine as-is.

> 
>         err = 0;
>         list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
> @@ -294,7 +292,7 @@ int br_mst_fill_info(struct sk_buff *skb,
> 
>  static const struct nla_policy br_mst_nl_policy[IFLA_BRIDGE_MST_ENTRY_MAX + 1] = {
>         [IFLA_BRIDGE_MST_ENTRY_MSTI] = NLA_POLICY_RANGE(NLA_U16,
> -                                                  1, /* 0 reserved for CST */
> +                                                  0,
>                                                    VLAN_N_VID - 1),
>         [IFLA_BRIDGE_MST_ENTRY_STATE] = NLA_POLICY_RANGE(NLA_U8,
>                                                     BR_STATE_DISABLED,
> --
> 
> Aleksey Kazantsev
