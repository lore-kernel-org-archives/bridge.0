Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3E20323
	for <bridge@lists.linux.dev>; Tue, 17 Sep 2024 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569093; cv=none; b=XSNbzQetmuXrKjQ0tMwPu5WQwMXj1ImpoSuJ++4pY2Wl/9Y1kpBxcFlgXpcULvtUIt09JwD/V4EK3Cgy6frpsEwSOejKtuEx7qqpHOwJqfsqq+jrN9i8jck0wuJITLeTq09pVVC+GPWPgVsowELNYxC7rBexljWY/p/ENlQbL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569093; c=relaxed/simple;
	bh=niUuXF1kX6414wT0Aeqg+hda2mZhNooHNbfvmAYjPp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gj4mOPTv2Km7C+LEd0oP5xhi/4kYw0VGTIo/ErPp8QV3iJrcecoYO1WwrINtkh2DX36CYC8hIOk07OCZbeqZzcQqk3LpoQUGILzjwBpgAL7k8/U6dE1Mr/+c/YFIM+b4qbue6JrGDBKCqpmlBeV5uPAFQDrrvEkh3arW48u/5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X7J3Y0fw3z6K5qJ;
	Tue, 17 Sep 2024 18:31:21 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 100041400CD;
	Tue, 17 Sep 2024 18:31:28 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Sep
 2024 12:31:14 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <alexander.sverdlin@siemens.com>
CC: <Mark-MC.Lee@mediatek.com>, <UNGLinuxDriver@microchip.com>,
	<alexandre.belloni@bootlin.com>, <andrew@lunn.ch>,
	<angelogioacchino.delregno@collabora.com>, <arinc.unal@arinc9.com>,
	<bcm-kernel-feedback-list@broadcom.com>, <bridge@lists.linux.dev>,
	<claudiu.manoil@nxp.com>, <daniel@makrotopia.org>, <davem@davemloft.net>,
	<dqfext@gmail.com>, <edumazet@google.com>, <f.fainelli@gmail.com>,
	<gur.stavi@huawei.com>, <kuba@kernel.org>,
	<linux-mediatek@lists.infradead.org>, <lorenzo@kernel.org>,
	<matthias.bgg@gmail.com>, <nbd@nbd.name>, <netdev@vger.kernel.org>,
	<olteanv@gmail.com>, <pabeni@redhat.com>, <razor@blackwall.org>,
	<roopa@nvidia.com>, <sean.wang@mediatek.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Date: Tue, 17 Sep 2024 13:30:41 +0300
Message-ID: <20240917103041.1645536-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c7a52a818c1ae49ad7e44bb82fcea53d7f53d6e0.camel@siemens.com>
References: <c7a52a818c1ae49ad7e44bb82fcea53d7f53d6e0.camel@siemens.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

> Hello Gur!
>
> On Tue, 2024-09-17 at 11:10 +0300, Gur Stavi wrote:
> > > @@ -1594,10 +1592,11 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
> > >   	}
> > >
> > >   	/* Disconnect from further netdevice notifiers on the conduit,
> > > -	 * since netdev_uses_dsa() will now return false.
> > > +	 * from now on, netdev_uses_dsa_currently() will return false.
> > >   	 */
> > >   	dsa_switch_for_each_cpu_port(dp, ds)
> > > -		dp->conduit->dsa_ptr = NULL;
> > > +		rcu_assign_pointer(dp->conduit->dsa_ptr, NULL);
> > > +	synchronize_rcu();
> > >
> > >   	rtnl_unlock();
> > >   out:
> >
> > Hi, I am a newbie here. Thanks for the opportunity for learning more
> > about rcu.
> > Wouldn't it make more sense to call synchronize_rcu after rtnl_unlock?
>
> This is indeed a question which is usually resolved other way around
> (making locked section shorter), but in this particular case I thought that:
> - we actually don't need giving rtnl lock sooner, which would potentially
>   make synchronize_rcu() call longer (if another thread manages to wake up
>   and claim the rtnl lock before synchronize_rcu())
> - we are in shutdown phase, we don't need to minimize lock contention, we
>   need to minimize the overall shutdown time

But isn't shutdown still multithreaded?
10 threads may have similar shutdown task: remove objects from different
rcu protected data structures while holding rtnl. Then synchronize RCU
and release the objects.
Synchronizing RCU from within the lock will completely serialize all
threads and postpone shutdown whereas outside the lock multiple
synchronize_rcu could run in parallel.
