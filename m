Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C3156250
	for <bridge@lists.linux.dev>; Tue, 17 Sep 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560712; cv=none; b=FhisBSrJ+K4KFWW1ZhDlJdbqlNd4rGsV/uDEp6q+X9zhqzUzR5CsZoFtF+wMM7p414KvgiedjtZzuIFWcFKGwrqel+2tKRRxoD1I3aO/LY57yI+B4T8P6TmHWAFHQAY0WarGpsEG5eeTAtGmLDIFWJlaRNBM6xMcNCJ8waRTQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560712; c=relaxed/simple;
	bh=a/1tz75QzdpcS31Z0CzWe5FpET4xO7cfK9BF2WGH/9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maQmEgmkaLBVJBfM4dafSRouhcMygAtPvUWyE1ulhJ8xAK+QmmpMgtJ6chISdh2B/pqZ+7U8hJ97XwW0T1LUDaxscXQw8YxaRWHRaZCEK1cP84WBpEmIATuMPpTfviwHf0RN+rvlU+zE82xE5IRIurJR6O0x/rgKxyW3IUBRvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X7DyJ0GDsz6K5rH;
	Tue, 17 Sep 2024 16:11:36 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id A9B4A1400F4;
	Tue, 17 Sep 2024 16:11:42 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Sep
 2024 10:11:29 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <alexander.sverdlin@siemens.com>
CC: <Mark-MC.Lee@mediatek.com>, <UNGLinuxDriver@microchip.com>,
	<alexandre.belloni@bootlin.com>, <andrew@lunn.ch>,
	<angelogioacchino.delregno@collabora.com>, <arinc.unal@arinc9.com>,
	<bcm-kernel-feedback-list@broadcom.com>, <bridge@lists.linux.dev>,
	<claudiu.manoil@nxp.com>, <daniel@makrotopia.org>, <davem@davemloft.net>,
	<dqfext@gmail.com>, <edumazet@google.com>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <linux-mediatek@lists.infradead.org>,
	<lorenzo@kernel.org>, <matthias.bgg@gmail.com>, <nbd@nbd.name>,
	<netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
	<razor@blackwall.org>, <roopa@nvidia.com>, <sean.wang@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Date: Tue, 17 Sep 2024 11:10:56 +0300
Message-ID: <20240917081056.1644806-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910130321.337154-2-alexander.sverdlin@siemens.com>
References: <20240910130321.337154-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

> @@ -1594,10 +1592,11 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
>  	}
>
>  	/* Disconnect from further netdevice notifiers on the conduit,
> -	 * since netdev_uses_dsa() will now return false.
> +	 * from now on, netdev_uses_dsa_currently() will return false.
>  	 */
>  	dsa_switch_for_each_cpu_port(dp, ds)
> -		dp->conduit->dsa_ptr = NULL;
> +		rcu_assign_pointer(dp->conduit->dsa_ptr, NULL);
> +	synchronize_rcu();
>
>  	rtnl_unlock();
>  out:

Hi, I am a newbie here. Thanks for the opportunity for learning more
about rcu.
Wouldn't it make more sense to call synchronize_rcu after rtnl_unlock?
