Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB532B130
	for <bridge@lists.linux.dev>; Sun,  6 Sep 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788690773; cv=fail; b=UxA8B+cDtnj6pUfkzn69Iky9fEL1SwGfZ251eHBLmt6kaX3z6ktzcOlK82YP+TM9uLTQ5Y4DqgztBUO8RXRtDa7GsyRus9SYvSFtTnB8V/MO3ogi0RcNIXgtQctrW3fUUc4wvlRwBx0Y2Bvm8F+v8Xs78vKlwF4jcZ4at+dyI4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788690773; c=relaxed/simple;
	bh=DPum5qnL/lQacCchOpKIXeCorlc91DcuRfCro25g46A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HIf936Ju6hku8SEIylsK2A9b8REHOxZLRCuIf7EZr0k4UQrqLR7u60wlMElrcED5+tmuI5smgaeW7RT/u8iiI4XTmmdbhoo+lrfV3I9e5TIuraE/+fYb0oBMytOA5qVRvAZxECd4lruPb30P2YPh1qVDQMCmm2USEKqrXBYN8O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wy7ltZbL; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wy7ltZbL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkAW6bVfNo7KR9Mnnf/JrmpvOie7NvvVwHSYN+a9FdARhkfTgAcjeHf+VTYWtDFh3e179h4eb7ZA2A1OkZwtKfGw0UmshmGL8N3pB4DvOCGCaq9bostOITEHDoMqgfUq/eJPvlmrLO+wR89qlgSceoePqFYMOvwJsVZIVKe33T3v1yOCs37DlnWmGGKIr8oEZ+wSfJYRu/B5CvEt6kB3BRadb2CYNnxB692iBunXKqFBbrm0GE1J59iE5I0xJAO4gOFcWSOjU3H5l8SrJpK02y+Xrkhpfo9EArHov1kabsfDbNEIXOuF1DsjodOiFtzLJ2elXB4gbxqFxBwKQ3wBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoejjMRaqzRi3qQ+i+4uCk5EFCXiiH7agLYTjaGjPYM=;
 b=FAjdvTZgdLjdgmJWW/x1vgJ1RKDuPy44QGnNK7LOyiH6dYVvr/gmrbOrv85ll1rI0PqMqMIOz3npD0whW09f4d6t87FcsmFp6y7BJ4MEljYsSaCe5mLBRezkIW0g+QeNUklkiIqUhEDyOOoguzC5VqJE91RfYb+RDMSMMjJ3kZnvZeh4SY2/mezHa8PmKopFVN69r9Th2h/eCV1UZyoQFl9X7/OdP9YbOC0JElKoueFlR3OpqVbgXBVqTLBdrz73WELyJHvkn3c6H/ddgBXfgDyABkYdszS9FzIwFINOOuh+Hf1mkxpZLiOAh7JMpOM8CbjAZLRnqHek7HAyQ5BS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoejjMRaqzRi3qQ+i+4uCk5EFCXiiH7agLYTjaGjPYM=;
 b=Wy7ltZbLjlDpjhFXgv4MN+QGIKWdSyyP1PkKcS3EoS64m79TIDwIjQzjY7sMjxi03b1J7KsGJ+nSZuHHfF3e2tgFWxqSCxfqm7hheKS6V26xX2RBiHL1L/sNHjnl2xQupm5XLKV9//042mEYunTj9n/wKawl4UTYGh1omksJGEwbOGq1Fp3wmbRc55G4j0z/SrLOH4lNY9/y8AbQtecaNI7rHaqFl8S/+k6F62fEmKUd8g8aryz3dsvp3mQ5aKq2FCOkwB398rE88NA91YsbQ++9ETVDgxNEPWxKOFl3pr0++Mrlt/GH1Qwp5CezlzmySM5j471wXnC/0VcHocmRBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 10:32:48 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 10:32:47 +0000
Date: Sun, 6 Sep 2026 13:32:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v2 0/9] net: bridge: vlan: minor cleanups and
 annotations
Message-ID: <20260906103230.GA203224@shredder>
References: <20260903143138.1574598-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 633f9e19-fa15-444f-af5c-08df0c0231e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SkyeQ9AgNNUhhgA+L6GmC9V3cW/8yxEyj1rsCNylqbdLXbJKiUMJN2wq3dQO86IsdCB4N26ZfLPNaVUDT8yMQIDDq8ZoStpa7uoK73l3MRd1X327ZIehpBNpC0iOeFc+XcHDmtKdYDRupKfORt/tAdBGa1DgOqfMxUqImOT1XPUgZPCKj1MggADALQX/6lSh9rSMhUPCF4xR985FzxHrxKxKSj/mwcWebdlvNPmnSQveCjuY5raxTwgBESqbEqiD4xwPDg/rwAFZFxlkrUIq2Ufb/xmPVXsimEIFFt5kXTNmPUPst93bySyNhn/AOQLiLDP/gk+yh5O1L1e2smu5F00SgyISpr3jiG/e09xhrxdio1YRP7tRfSPKsKRx/G3GZh+t1xQ4nsiAjrcgIyLSAk5ifgqAtKuW431Ec/hCAR59WQ5tdsKhW61uiShM8WqAkWsPWfPgqcT3ZCyYvQuhQHPizGH+qPtBoCb8+n1XJj33QUvZl00zfnr/jC/sab0uAB0J+MLX0vu6fGLBKH90hJ090Hrpzr3IAOsJk6DIFjyiZ7Dp1BxXdB0YkLtQaPzxGkt7vx2oikGodzwn4zdtIrJUqKfbg9gEfMoEaiTLUqFBw3zLfxdOeIvlm4lYa8jJ1tazQhkVhSim9VmEi/tujusAJraRXtlAul75BWAezhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jYXEDNyskP0sLeUBm1k3M7VRnrb/YkIDfhGaG7fdlHTNbmYprl+n8CTv+Oqi?=
 =?us-ascii?Q?wtixrB78NvsfvIgMHaFLhs6EuHJO7GJRZloJrgiODEFztvFRYmFKHGhprcCD?=
 =?us-ascii?Q?FSoPJpNO6pGrTzKqVJVWv2CLXq7ICIhRkQ0fE2AM4wfbv5UA514a6Mk0p98P?=
 =?us-ascii?Q?N26ZnKvWKWeuDuZHOgGmEppNVAAdT+CGyJaxR9AIFqQamESmVgTRX3K6Bh3p?=
 =?us-ascii?Q?Rhe2HUxJ97QGlrctg/XTwtDWPHPik0qDmtWpgByuJtAQ78lMcghaowGga96z?=
 =?us-ascii?Q?p2Pi202H1w2R0wjpJUMXzAmxDOwnLWz79xMNraBjmXXicNCAfD/gPnOfAIfY?=
 =?us-ascii?Q?Rsrk1KKR6Zb+5ZzsKsSwI3XqZjQwERHuI0dAFPmPdCOCRHQgzBIOGqrGJKVd?=
 =?us-ascii?Q?lQ/IrOR7mtgjL0J/sSuROFp8d9RfCjwUSobx0qHt2Cd3a36HYbCcdmGD4n8F?=
 =?us-ascii?Q?cws1liH1R3cXwK5rY5Zl/M1e1tU378x4qmPUxFgy5I3RAYYB0xZ+5Jst/iYZ?=
 =?us-ascii?Q?UGSVQTFkn3nLPj322/TlSqnet31qF+cFLCpFwV4uCo6p7A9KhbECwO+baY7Y?=
 =?us-ascii?Q?j4t1wvtJ+6m4fF/dXjn5lxsHp89BkT/BwfWH6cRS1kPa6DX0JfPuA+j+sAAy?=
 =?us-ascii?Q?cw0wxoVxtBpYzDzJKDAuqMR2A3hDUvLbyIJAxEZvD0TaeMLc89haLXay7r0v?=
 =?us-ascii?Q?to3GYHo5ALawtsZirX6e6thG4lAELATkivry+Plim2IbA2K+e9kuNkQhXLSS?=
 =?us-ascii?Q?DWYm+xLouKFyvPXmQS7fIFk/3G7uFy1jgdYDxas4lPb6pvJuQ2rY2HIlV5YH?=
 =?us-ascii?Q?EVdvun7ruhjICX1P1iBXEdXPwTks7VwW7G42HX3ZKNVW0RZA4DgeKi3qgxe7?=
 =?us-ascii?Q?o0NgiWfylUeyUq/F6EPliFKt85YErRiHMTHKRroxHkzOJ+Floc8l4Ml0n50H?=
 =?us-ascii?Q?1EAMT2wOeDI8atUbHu3yUBUo2rimZUxN2/57DffUwE22yD2rPhq+2TAfh9S9?=
 =?us-ascii?Q?qsp/we0eL5rZwvHFs8DLnMhLoarmXVLEGY/+n83aUexuB/isI0gMXeF7Jwlu?=
 =?us-ascii?Q?AyebLnlT+nvHxLikUcJX0DnnWB3uEwIpvbXJr/Sw+Cr7g/ZaHUvRYGzG6XuX?=
 =?us-ascii?Q?0k6K2nAzWZEjUKF/Dd+bRBewP5+atAKGJENZO+d8tGJTz+iqn2foLPCy7D7E?=
 =?us-ascii?Q?wQIxO+qtXJh6GvoMOYRxEwEEqqDExBRIoCL+z+X+uTe6HiYqJbHBn+lLTCR7?=
 =?us-ascii?Q?V9fQwhU2YmtfvaX1oIPXXhKT5CRBMgwCuKEvH5/4jaGN/FCKBwccDAP7ez2y?=
 =?us-ascii?Q?z9rvAta3QIcLHqWS+A8BRgcwgrR0zCui755t6y/fluOJdHdhqatVpOdRz7Xc?=
 =?us-ascii?Q?fomw/zqiHHX8BxQoOp4U8n4rSDkUBeswl9N1RIPM8FlL+jgZY6+fpo9tcP/D?=
 =?us-ascii?Q?gglFSPL5aVesoEY9MyXyTDW2Ot+6eC90n7pdwqVdMuW/bc7stFcNIXb2+b5V?=
 =?us-ascii?Q?n8p8lOH0Bts0QdeTQdzCpFmUGZWmgOYG3zMi849ACPJHBXkVIVK0PxBt1lQI?=
 =?us-ascii?Q?zNY0eNwiPoyPW6meZM5hqs9/0+k6Rk15rQp+6h4KQoWDFGnbq93rtlkcbFR7?=
 =?us-ascii?Q?GYSCZ71wSpM1zTvpFstzYDzlTZpecf6chYPI/wXMS7m22XBSshCHG7skormO?=
 =?us-ascii?Q?QtF6FSNQsYgzFnx+G6EeT1c2pxVi1d0KUBr+wDed7/ewbw86?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633f9e19-fa15-444f-af5c-08df0c0231e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 10:32:47.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Dgn+agzUQeo5QC1qKiZlnK2hbFSbbkLzXaqpSCAIVs9jR++S3qrRoKqKdIeKdCoSv5kloEWWBJCCxkek7zUPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092

On Thu, Sep 03, 2026 at 05:31:29PM +0300, Nikolay Aleksandrov wrote:
> Hi,
> In preparation for a complete vlan fast-path re-work, this set cleans up
> a few minor things - removing legacy code barriers that don't help,
>                      annotating lockless accesses and using proper helpers.
> No functional changes are intended. Sashiko will find many pre-existing
> problems, none of them are related to this set. I will try to fix
> everything pre-existing separately in -net, there will probably be a few
> critical items. So if there are missed places to annotate, or if there're
> actual functional changes, these obviously should be addressed in this set.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
