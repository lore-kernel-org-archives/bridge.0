Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC13AC0C6
	for <bridge@lists.linux.dev>; Mon, 13 Apr 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070044; cv=fail; b=E6C/DPuaMQg+aBsrwE3mw4cCCoCx4GpPORYzHM5n2FQma85AFR1sNMLff6r1oPrCJEr+3RMrgfUQsm4B9/fhheF/Ex/31a29Bh7yBs14iI04IigFaSBeJ7IgjYbGKPdcxWsDLO9H6nUy2PoA039XuAMIHNeIJcuA9GMuTcOC+rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070044; c=relaxed/simple;
	bh=8Laz6H5GeeXnahFjQy+pU6Q+RHRJ0Qa6dToPKsUA/Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ozG0vnKKBHz764hnRxSnM0Pi+HBD/2uMVD+4AOH4SQ36ihxb39fodxhTFesO9X0l+QNF19fb0hGfweZZPwibm5vE+iGhJXXwA8i2c/oyvjTUL5fxWdGlXoW/AVxnH91g4rYKahERjr449QwuxPKjU06qYC+qSlm7/fBMpB1Ui0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gydySEhq; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gydySEhq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXUNQYvFy9y0tVe7d0oOX8iJnXa7HdZsR/FaHGJcrC8gGCeElJ06T4tlSwfN0tKqRS7JMfOXu1g2P9oZ1Ytq2oT4gzWZs1LYegg/gc1XTFNKYfkrREcGva21RJ99pS4hBmiZTcIT29Q9SsNiMRegOqPDNmDCF7JnkX08L0H9F1Ddg6nDL7eRySMS9VrDxhc88LEhA22jDtPnstQ2oBAxVWQj9em26/XuDSmBwhIcGVdcIhlxAx7osxhZIu6PqT1tdQtyMioBHTkEt9uwvLdiVLe6t8A1HnYzgP59CXs4u3QSTLggAzpJkwrK9Rz7r1U0+RFWroRv51CaxgXZIIiGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQVXYJ9p/hL5bcGdQWpG/yB2eIAauy92iie5c2CbXYI=;
 b=hido/LdhtqVp8fmJKLWKXgBYtRXQ0z0QUpSya4Z4Jp5DBwPSzY5kYwG6pwKsVnP18z17ugy5YsZgZG6uD1mMgM5s4biU2FW96nTmExluCRKB75tZ6TOQl7a28tGTVMNMUmgmMZOoq1vqzM7Jt3hR8qvZBq/wTvYak/+7RTLdc4VQyRf3f06x+Eh47D7+FFeZf3DJcc4zVSxa7nw62C+Q/tr2L8EKAwwcKahw9r59z4NycRVd5tXBOr29xQWIDSDLqQ4XpBwSMLshth0q14aR5XwSqMkzOOFUtQyQaWWbYpX5sSiepRiHaAJCP8Mhc3lvqCmFPP3YSdgiJrAOqsf9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQVXYJ9p/hL5bcGdQWpG/yB2eIAauy92iie5c2CbXYI=;
 b=gydySEhqOCbq1kjMHqUV16NYhhravCN5xYr5Qrz31cEuyp+kNOLFVwd3XAfYSwXZN9fsnxW3i8OfDyxxsynR144YWbR3vMLrGyFslnMRroRZOBWPxUHNKLY5Qnk9TkqWewW4xprPdL5aWyepvvUTP4qoljzLF0EEoApySG3hBFbQCwfqkiP5itQaixQ48xvDKSu+Hxj+RJGCeKrnU8K5s8/H53jSZZbjxbLMxXep+M6VfN/rNNukRjON1k0mG+Na6Gp4P6QF/YiIcpyrRyVKvjFcx93XMpNhcXAEOkcMGusMrXBJsmuZU5MCO2rYNweSz1SIZd1Bc6ksqGFMA3+csw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:47:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:47:19 +0000
Date: Mon, 13 Apr 2026 11:47:10 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/5] ipv4: igmp: encode multicast exponential
 fields
Message-ID: <20260413084710.GC209364@shredder>
References: <20260412111047.1326-1-royujjal@gmail.com>
 <20260412111047.1326-4-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412111047.1326-4-royujjal@gmail.com>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e382d0-4183-48d1-4d42-08de993945e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7nSUaM8m1qSaPG/NHwELHZbla7YazKc3t+PTDzgoD5+Qh5L7wxtQuLXwN7sSnndRJaFG3/jR9Yd8PY76oLAw+OCtnWnZwfIhg8EqfsWFRsar5JKRz4peujzaEUr/cKhOoeOXEYrmCbMI2fVrE3igz9X2aQFE7rA/9yne2onWpwIxR4ZLD/7OmFRxcXUn3yZBAspZD+QBaNYG9XZaRrhCWRQg0ZV+M+5tO5cXam4M0fiYZ0Q65sPSkMxMYA4PbmBKZUvCCbkSh49/blTJjmH0nsxl/2Qw3JtCQAMSPjrkcN8PhSUagrfc7jC7ERL2woiU9UJOgNW7Qtqg0qOVyc6d4bAdjtiimjhsiHphyGbPZQWtZtkUvGIVoxu5n/AmSD+sP9gc4KAxbfEYhayTqVgH4pPOGT1J07ruN1FR58o6vkhiz1+wzuwYESLUbOuJZ1yVeTDTLgGyOQu+6bRUL8oGc/g8VTe0LeIHssVZ+ScY3SGcx4l5TzJt8qGhffcsc/dpyplikvuIKxCsPh/E1U6Jo5L9lqrN9AfLyKmYfXmF4ha+k1oXl0Umk9LMFg6nQM2HiKT0dm3FusrBiYtrwCAhN436uYhoFDZnFea+v/ZDk1x7HRtaX+Z5lXgkaazERG1N9KTnb4uLvZoURyKKVEzi21SqHShqV4PW1/oF8iL+5b6rQqZYiOcbIKk+4fcXc0Q1FC5qjsgwXOXd1kIz+eiBx99ir3gvfX2hHyL2E2eTNFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y8V/enAmhwkpoHb0Svp4nlo1IG5Mwb3Y5HawKARPqMUH73n+D9s7LNckFtk9?=
 =?us-ascii?Q?ugjJoZAaWB40RIFYk3+JwGJQMXwPMr2gNhr/YW1nf3w7Lg488/3TkefETtJx?=
 =?us-ascii?Q?AbM+kN26xvaZVRujo5HbBGM6fQl2wkgSX/2kQ3yAe0AVJAgdh9PgG0GbGWk+?=
 =?us-ascii?Q?to/sGtNfqwSyvHoZgYQO3xNdxLG01QPJaNJrrwhth5ccLtWod3CdOUZ4IijM?=
 =?us-ascii?Q?AmOzJvsgEe7K9aLW/gMeX1Q24DtBCMHHRJKxeYR+OTL9SbnPMjn3nzzJQyX2?=
 =?us-ascii?Q?qcFGntMZ3J4T0PG5yVyzh/xTTOuDGwgx52fcDdqgvGf1hrQJCCaLfUqYx2YB?=
 =?us-ascii?Q?p12h2ix+VTe+0ARQ6W93xJGn1M7bc/7bSd1BErP2CgLHgP+sT2UYar9SqpZZ?=
 =?us-ascii?Q?6ca9AxqbqwKOh+eWGifkZo2CUa0XCkkKW+Vi7mTG+ahOESExsEgfxnvhQPvo?=
 =?us-ascii?Q?H4IppYA4gKZXnQMZTDZW7SknBSXh6WL14tGkyU/5bP5Hbn8p7hbIoZWv/1FM?=
 =?us-ascii?Q?kTt5s4FaR+8uwLIboINJdMfCbay+MgL/DDZ4KVdNOe7gTpRvgs4hCm+RZmle?=
 =?us-ascii?Q?eg5kwyX6IDaOU2RZaz1fshz70/Pw0cFsZgg3WOrTS5c1fQ72Ts/za7143O6a?=
 =?us-ascii?Q?DF0EcY4EI7ouiehU8mRlCi9huhjxhzf3J6DnxEFp2XZ3HRSh9PRkjfQRFZ6e?=
 =?us-ascii?Q?Thur91qAEkU2wb90D9xe9AxmmKcsrlRtyDSyoKFE3sSc1kkkMFMye36alzxU?=
 =?us-ascii?Q?d3VI8b9hEniP3YSP34Wl5/olOeOhbFDC3E1UMQhYlFgM/rGMMjoeUQvsP0Pm?=
 =?us-ascii?Q?IUKRROW75murWgfJCrSGW68WCAzjnPGPJw/20BEYd4a1DyTaF4+Dq6q8mGC4?=
 =?us-ascii?Q?UL+rTEYc9HR8GQpDwLQtuxSYbSbJAflQqwFQPEb/Gn085PmuKKOVX2eBDWcX?=
 =?us-ascii?Q?9FtnLDW2eV9PeBBb/pdsELve3R7N1BVseDi/FmgCCQBUcTReDgFVDlJybdgG?=
 =?us-ascii?Q?xSJjdAmsm6ZFmEIp0ssZ9Di7g3NHMOSUV2x0sOvMJlPdpJAp4PNKBkFs0kYE?=
 =?us-ascii?Q?T9lGtcS52fQgOZRj/Vkh8j2/NdXa53XrdcuPoB89Crge7mrtxVqqKuDntvqz?=
 =?us-ascii?Q?uU8nf1WRiyR+s98Vlz/vJh5SvKnazyHSq/xXQX6M0uxfWeBL8K/UlIBGkz4A?=
 =?us-ascii?Q?jAwn+uuNawOswwyJW1KfGUiE7RJAG95juvj2Oki2zoclZ+9HXJPttA9nA50R?=
 =?us-ascii?Q?Q3LXsgVBUMOEcUta3j+qNHPrB7odtAWT8ReDTkxidY2uMLH9JRdb93aBQdAR?=
 =?us-ascii?Q?gxUkAEQSdgmt/+CncZCAWkKIBNSXiSPHyCrgObt0Gwh7HD4j4+IQjtDDJS+s?=
 =?us-ascii?Q?Sql/F42nEJiOKAfBkYKow8pqOM3NdAKvmxyMnIY0CDBR+qAQvpPt4QNjO2bH?=
 =?us-ascii?Q?gQ39MT/+0up1QoU0aaA7AHBtxzvvn76y62enFA+hhv0DMupmqU8eD0t54Zag?=
 =?us-ascii?Q?6xtBQxuWN/DuTgbtnPhk3UWzqc6UpM3To/Ix/tu7KX03zdGRJP0TeHWMdw0V?=
 =?us-ascii?Q?XAhV0pXFau/CTrmvebEHUIvHyuRjfSAqHB7PgEaBxowDrNGYAtpvPLBKdqRb?=
 =?us-ascii?Q?G2TBkXTuxrb2fmie1ATFEjlem/Wvg5fk/QyHbf+HjhjYZZC8U19qbR82WNJo?=
 =?us-ascii?Q?jwhzh47mHJqEEKiNKwaMQMcENowB+KH5P1IRnDD/lcN/q14r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e382d0-4183-48d1-4d42-08de993945e0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:47:19.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HFiydVj2BSt5G3xH34UoVN4SbvqMNi6z1AkNuT+iK+Aak6nuc2FAFYkGFfKrUG3Au2jP+ri+zx1/w8vZblrBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772

On Sun, Apr 12, 2026 at 11:10:45AM +0000, Ujjal Roy wrote:
> In IGMP, MRC and QQIC fields are not correctly encoded
> when generating query packets. Since the receiver of the
> query interprets these fields using the IGMPv3 floating-
> point decoding logic, any value that exceeds the linear
> threshold is incorrectly parsed as an exponential value,
> leading to an incorrect interval calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures MRC and QQIC fields (8-bit) are properly
> encoded when transmitting query packets with intervals
> that exceed their respective linear threshold value of
> 128 (for MRT/QQI).
> 
> RFC3376: for both MRC and QQIC, values >= 128 represent
> the same floating-point encoding as follows:
>      0 1 2 3 4 5 6 7
>     +-+-+-+-+-+-+-+-+
>     |1| exp | mant  |
>     +-+-+-+-+-+-+-+-+
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
