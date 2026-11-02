Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608353;
	b=YW10NK/XBpEBdv20iv/hE+Cwf7Lz+BrMyOmkcGiPGbI4oVWVUhJFinmziB9VpNyxRxNl
	 jpE6Jw0iNCkZ9Xs4x7wMqRMsFXP5msASc00ah1UrrTlFH6amFlPEWRTp5JQ1gBLvFFGPS
	 oTASu/H5SxCdZr3ZwPYJo2wNwfTqlwUHsXGYY+GrrezbeEFMaTp0AlFc2Ne9cplLKBl80
	 wUemOrD0/k9X+Crepz7ntg2pEMthpUy3y596d65jLC0ZibA7Dn/0+eU+V+cM8sip3mxl/
	 W/StSQlJ3sl4OBllN3yqik2GgYdEurFuIE0yJNGkJPdOMT5f3il7aG8R8SVqpHGJaGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608353;
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
	bh=PJNCXYIN4tLzumfSWxbAhtwN90Qu9INV8Dum43WK9W8=;
	b=o18kSpEwD5SCNeXU4cAlODxanwAyPOa7qhze/K9fIX98iHCgYodE+xcSNUwGvGmDk8cA
	 3Nr/ZVGSE4HZRHvfnygGS4/xqRrQN2v+ox6wpn+yGsJw7WKnN3g/EScGddKRKc6UvgCJZ
	 q7Q/LCjAxJU7l0NkZOxDVu1bkxCow4kqBrOw+ATrx5uaiC6MMR8Q+YJUCRYiFAHnBHhBH
	 hL3XR9OwwYHwt6eLXc76SUZeDfzby9kp4IAt4q21Y3G0PCCEgaW4FrS0pqL2VgpIA7GuV
	 8a4Wu6wrKP+kE+saEQs43U8YKZ1je6p+bs9P4UWjIs0jvYxFIA1CxBwNASPYLW0yddw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Sp4dzyk4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.21
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76663606A329
	for <bridge@lists.linux.dev>; Mon,  2 Nov 2026 08:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76663606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Sp4dzyk4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScL6rWiTTYZU6YAngfxoOvvqkIanKgRjds4+PjPTn8/2m1MnNFpjp4vNSr2z9C+/FXKixFYKUgD2QpE4OZgQO89MPvHHIdLwridRHd4/KqXsb/7je0ZjY6QDlUf+XVuiV4+R3jlNul468AZSYs4lcUXYt5mjSkT7iE1jYVxhyRveHtxofl+GJ0laaHCh6rrh104H02EfJbScqM9nyacijwzlZiZORs7eHHcZOPVmUdDaP7WMH3gE17b4jH8nq9vp11zS9qLdF4+w+d40vxBm53agY3vUBL2fk8Mh9iQQefSDvKO7TBsq2rsZnLEMvBoX6LOVldJXhoXep3fREMaRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJNCXYIN4tLzumfSWxbAhtwN90Qu9INV8Dum43WK9W8=;
 b=rOPOCC8QLswTwxNpgDFAaOz0VP05EZBZE39DiIzSc9+/qg9EBunK6ce088vTUYx6JXIWhb+tDUI3aB4IJYMUHZ10cvlmNio9crtmtZgZ1atOg/bbaOjU6frrLhf9W/gCKPn80xCwW/BuY4kj4H4JiOYxKbYTjQa8Lgkl700wb3joHVv+uoc5dg62QOV1Y4PlCcikCc3cAePy67dgr7Y8BsYA98TTHhDrmb7yv66eOaM1Ot7fKvAzkBmmGoirZP5RrpAbkTK9Z30EcD9R89+sHjNplLnLoUrAoBj+cclbGghLsAJvO4/uq8eGUBlX/BxwSQcBajQLZLYImdM6R3UruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJNCXYIN4tLzumfSWxbAhtwN90Qu9INV8Dum43WK9W8=;
 b=Sp4dzyk4uElbxw0v9mfH0CZ+0lo6pPERzvqwmuxUYMCsoVPcYXwKmzEN44nGDlY5ox2zVe87GiSqzzmakJaOOHyNPMWqVSmsGDHji5xw9yIjYAZopzmuswFzoPJofBiCmlUgQ4rqADrB19UJMXhzFYmw6kz/VXuIYR1CK3Nfsbef8VI/mITt+IxZqI3xvktLHi2OfCY1g8GYD36We/FMUSrfQhGjReOg1AORRoNZoSKkzwbNIRZ/bGRAqCMGcKaABag8zoivy8cqLS0eg+KqoVd+C/YQAhTW4ccXz5vso/6GWcGsYCGpT3h2jEcJ49LIH3VhhsV+PAH18DdeHrb0fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Mon, 2 Nov 2026 08:32:26 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Mon, 2 Nov 2026
 08:32:25 +0000
Date: Mon, 2 Nov 2026 10:32:16 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: xiaoblac <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: bridge: disable MRP ports before the FDB
 flush in del_nbp()
Message-ID: <20261102083216.GA794532@shredder>
References: <20261101044840.1595584-1-1020691186@qq.com>
 <20261102082553.GB778610@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102082553.GB778610@shredder>
X-ClientProxiedBy: MR1P264CA0140.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c267fa0-b331-4551-4166-08df38bbd2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261009223027099003|261028144727099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	jU49IPA87kUs3NAHdEAsJBFJKa1SjusJ9nW8K5QfKAfY+kwPXuVNYv3GALYcpTL9Cy7Y2OnyubKFSrKDxmhPt9I6ZLrvUZItlLPFcIAh0xpgdpEuXst7vY3v/aN7PFWTKT9GRvOjk/bFWSTDCgW4udQTAsj3wpnFwaU4vCv9lt3NodjCqD42dHQnTzz4GR52zxpM5X8Vg/74xrOJcmfrGF/xss2nG7cVBC/2sG2ikniw6Bli9Q9IIbWNd+E9v3rlW8Ses+WqvZP2ovq2bb2BERnifejiqQszbVvBfdj1kaFE/Q/IG5QL88JWyD3nZ8w5/R/+4Y8DAsFC8l4PPJ82lzgLRnynBgw6SqbWSf0IsKLtueeMsql/v8Rmi3uwI4OkpQX7zxQSL2FU/skFSy7JTwJd1tEMR0dcGiwHVnTKrxrruSma7fH/1dFylDXxJKTuse/mNoe1rOI8oJAW6JQUOhXqyrD430BgIQNoGLjGSKyqjs566bDQDqNFKlX+Ok95H9yWUKeZ2CvTlFYZdAGe1CNcBtXhrIkNWV7+wBVNOtOrnQgYKGydHFkWmMYiB8jjBX5p3YzbAL6MxhKQvmskG84BEcD74IwV9JZ47GZW4A5JuB3Zpto3ylsJhKDZnM7OZ49ETvrBYdOYBeYczRLTXhn0VrGkAkEK4QfG9uuo9kk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261009223027099003)(261028144727099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i2vtULFdyDF7zK852mx0EtJrZqsgjrMTk3pTsLANqrH7KOU2UZEijr8v6hXB?=
 =?us-ascii?Q?3WQ64eYQfv0ttfyydIK7hSpEEO+Nus+QSdX9dX5z+0vm7AT8IaX0udt878kB?=
 =?us-ascii?Q?TkVXQHuBc3ed1cUx/pq8zDvQRu9lO98DodFEExXeoeK8TGh2F3qqGpA7FOxf?=
 =?us-ascii?Q?oTHFe/IW2hbMv2etvYcSxzBV2Fobuz7JNQLHUVIXIIOuKRVLT8WpPfyEQgjx?=
 =?us-ascii?Q?gL6ROEvssU2tiRiW7c8pOHdsof58yv7A5EcJnJ0tllBo2t++/LkW7vqz7sLE?=
 =?us-ascii?Q?iKL22CCtyX7Aii35++XRecDUAVP+UbNZfNxxQgtcst9BXTbF42CSRYY/D3fS?=
 =?us-ascii?Q?g/iS4cesidTXgXl9Vx9jxmn6wXNvuQjk4WwRCcJyNYb0gvBkF8OxSIDa7tTZ?=
 =?us-ascii?Q?Gj5SJzVGzeI0eu0t9ZaHJ36RJvCDEQEIdhhslJgO2+zuhoZdJJlA2j8sleqC?=
 =?us-ascii?Q?ILH57Lph+xXVYajhcDgRrHEG1+9Hu3PWQ5YtBBbBrkL6b8WyR7Ru1HEtJTwl?=
 =?us-ascii?Q?0R1K1OnQaWnczK1h5eK+/Ntv+Y2RDiae0NXNLFeyddOzF+tCl3Xoq5L5Pj5U?=
 =?us-ascii?Q?m1YCke9HZNsZwz0kkF/YDfg4DS0H1blqPuknArtbMFVnW6Ondmm6/m77vHWj?=
 =?us-ascii?Q?OJ4MEZeDdcwTPFWr+Zc6t7wf0NKmuIMZGQ/67fyUYSZqFcnaD2qWhjm6Vmc5?=
 =?us-ascii?Q?VCwr7b7/dLghIqyh9zlIZitxicXzFLzDJlWId4MS6BiHb3Yqam8SOxM+a7TF?=
 =?us-ascii?Q?JPDlmIX/GAUhgmSNRRFFoW/jqYT4D0yMfJf78/EyEDxr73hnWNKp4ibFfo+/?=
 =?us-ascii?Q?yRVpzlaHlOCq9o9jtGMCR/ldjtB3ypcIyXi4DUeSY0fUtd2JI5BUBgapyFN3?=
 =?us-ascii?Q?T3AYiV1S/Zpk9GBn/ylsxMv0KLcV2CFuzL+fZ+XgqPglc8j57/h3iVE9kDOJ?=
 =?us-ascii?Q?LKS2ExCA3xjYLheuuFzIuEORwRLFiCiaxId6uKz9ft4F387JLmrwpy6vN7jx?=
 =?us-ascii?Q?INZ1ShZhcqe28AOtNaT5IyrDeldmv3JF0CfjeqNeOmEXJayKXNjZjY2RV+3o?=
 =?us-ascii?Q?ArwsulhsAtQbE7eL8SsuVCRPIlgIzNoyeDTUk9kUh51qeqXlSRpETByMsNvT?=
 =?us-ascii?Q?h4NU8z1xwApKUgma9WwhYOd4hiV4VsZmh6uyRM2kR0yxbNNY4+ndMos3mdPg?=
 =?us-ascii?Q?0PqZTFaS/QleHuRqR99r/9GNIDDcWYI9YeeZ+RWcFxry78WZFeQuRq+dhhMk?=
 =?us-ascii?Q?ZI+HaUfQT6NU1ZxylrjFcMCsvTV3W8l6EiWoeMfpKWyq+/aQIggMYJoSilzo?=
 =?us-ascii?Q?1yoxrsLK7nJq4aRcL64KYBJthllG/ueZ3wSDUer/wQl6L+XInXABOC5hOSu3?=
 =?us-ascii?Q?HbuH9nuTafuXnaA7kEv05snZMirN9ErfUZMgd2KO9VqgmWfLrjhIJg+b5dQk?=
 =?us-ascii?Q?iluiRT2fs6qinbgPjUeuhiOIKXgqb5KXJ6KJRh9zLTRkAfAlKOMjEbdG+9y5?=
 =?us-ascii?Q?kXg4LCoIe9U3YN7rBdZtRfT3B2egAXH1Sj1OCunNRXvxb/CuJFhIfRkn3Ps7?=
 =?us-ascii?Q?eHU2duf/5DTkrk9c/PBoSi85KJ9E/HMMR5+J4dndBzg87QrDEGLIZpU0SYEE?=
 =?us-ascii?Q?wG/PiOOSKKARsJ02en0j0G6QgOyVCsAJPuEyn+QZW/dQm89pyShdXHATTeAY?=
 =?us-ascii?Q?/54hTqj8SD+XVBkOZsm8iXzcbw3SLuy+WDluvOBeXDM8UW6M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c267fa0-b331-4551-4166-08df38bbd2ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:32:25.6627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/04/lrqLmx9Zou1QjtWaRI0GL4nAETHW2isI4YUX40Tm1nXT0b2IMbVlzZWrMy8ZTYEmVAkDbsGHSWUEAMC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324

On Mon, Nov 02, 2026 at 10:25:53AM +0200, Ido Schimmel wrote:
> On Sat, Oct 31, 2026 at 09:48:40PM -0700, xiaoblac wrote:
> > From: Cheng Yongkang <teel4res@gmail.com>
> > 
> > del_nbp() flushes the port's FDB entries before it unregisters the RX
> > handler. For a normal port, br_stp_disable_port() moves the port to
> > BR_STATE_DISABLED before this cleanup.
> > 
> > That does not hold for an MRP ring port. br_set_state() ignores state
> > changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
> > the port state alone. br_mrp_port_del() then restores forwarding when
> > the bridge is up before clearing the bit. A frame received between
> > br_fdb_cleanup_by_dst() and netdev_rx_handler_unregister() can therefore
> > create a new FDB entry referencing the dying port. Nothing removes that
> > entry before destroy_nbp_rcu() frees the port, so a later frame to the
> > learned MAC can be forwarded through the freed port.
> > 
> > Remove the MRP and CFM instances before disabling the port, so that
> > br_stp_disable_port() actually transitions it to BR_STATE_DISABLED.
> > With CONFIG_BRIDGE_VLAN_FILTERING=y, synchronize_net() in
> > nbp_vlan_group_unpublish() also drains receive paths that could still
> > learn with the old state before the final FDB cleanup.
> > 
> > Found through an LLM-assisted source code analysis workflow and
> > reproduced on net with KASAN and CONFIG_BRIDGE_VLAN_FILTERING=y in QEMU.
> > A diagnostic switchdev module accepts MRP objects and delays the
> > NETDEV_CHANGEUPPER callback for 1.5 s, holding del_nbp() after the FDB
> > cleanup and before RX handler removal. The reproducer floods the MRP
> > port with rotating source MACs, waits for the port's RCU callback
> > through the module's rcu_barrier(), then sends frames to those MACs
> > from another port. The unpatched kernel reports:
> > 
> >   BUG: KASAN: slab-use-after-free in br_forward+0xb1/0x820
> >   Call Trace:
> >    <IRQ>
> >    br_forward+0xb1/0x820
> >    br_handle_frame_finish+0x148b/0x1e50
> >    br_handle_frame+0x90a/0x15c0
> > 
> > With this patch, three runs of six cycles each reach the delay without
> > a KASAN report.
> > 
> > Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
> > Closes: https://lore.kernel.org/netdev/20261022090431.3641707-1-teel4res@gmail.com/
> > Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I replied to Sashiko before tagging this patch, but looks like the mail
didn't make it to the list. The two issues that it flagged are separate
pre-existing issues. The current patch fixes a UAF and doesn't make the
situation worse.
