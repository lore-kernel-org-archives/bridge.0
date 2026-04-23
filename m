Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [50.20.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303226AA93
	for <bridge@lists.linux.dev>; Thu, 23 Apr 2026 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.20.195.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912805; cv=none; b=rKHHksQUOoYpd5Bv68a3RfIouEEiA+hmpjcU4rnreefmRcXzvfth8CaKv9ESCTyOTMZlrcgxoE16pqobc3JyFG3fZYVdwNJiwBuTm3UiiKVEPZA8gbk5U5nqkFeHYq8FD/DbR0jCne4Geylp/PLc7OFap4yKrt/3e9D+uWrlZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912805; c=relaxed/simple;
	bh=ncskTVHsX9Hfe2ImeJP3V0bXdObuDuc46kCl383gQnk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BtrqskwhF9hm/SGQYYFO1B75oyZMtozS1FA+v1B9b2LYeEuhmiKw13+Ptd8/+GXsUAwMBim/rVr/BdbamYPbSLF84XinXvt8Cnh6L4PArhSRRTX6VwQj54NHVwyh8fzsy1qJyOItwmds9paT+gyeYLLEFVwvW0cQrA0fDkF1fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com; spf=pass smtp.mailfrom=redfish-solutions.com; arc=none smtp.client-ip=50.20.195.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redfish-solutions.com
Received: from smtpclient.apple (macbook4.redfish-solutions.com [192.168.3.6])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.18.1/8.18.1) with ESMTPSA id 63N2fckv405223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 20:41:38 -0600
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
Date: Wed, 22 Apr 2026 20:41:27 -0600
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        openwrt-devel <openwrt-devel@lists.openwrt.org>,
        Guy Ellis <guy@traverse.com.au>, netdev@vger.kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        linux@armlinux.org.uk, tsbogend@alpha.franken.de, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        3chas3@gmail.com, razor@blackwall.org, idosch@nvidia.com,
        jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu,
        herbert@gondor.apana.org.au, geert@linux-m68k.org, ebiggers@kernel.org,
        johannes.berg@intel.com, jonathan.cameron@huawei.com, kees@kernel.org,
        kuniyu@google.com, fourier.thomas@gmail.com,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bridge@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <68316F0B-2442-4492-A041-E57EFC58AC08@redfish-solutions.com>
References: <20260422041846.2035118-1-kuba@kernel.org>
 <accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Scanned-By: MIMEDefang 3.6 on 192.168.4.49



> On Apr 22, 2026, at 7:05=E2=80=AFAM, David Woodhouse =
<dwmw2@infradead.org> wrote:
>=20
> On Tue, 2026-04-21 at 21:18 -0700, Jakub Kicinski wrote:
>>=20
>>    I'm still deleting the solos driver, chances are nobody uses it.
>>    Easy enough to revert back in since core is still around.
>>    The guiding principle is to keep USB modems and delete
>>    the rest as USB ADSL2+ CPEs were most popular historically.
>=20
> Still not entirely convinced; I worked on both USB ATM modems and on
> Solos, and the Solos is both the most modern and the only one I still
> actually have. And the only one we have native support for that could
> ever do full 24Mb/s ADSL2+, I believe.
>=20
> If we drop it, OpenWrt will need to drop support for these, which I
> think were quite popular at the time; there were a few UK resellers:
> https://openwrt.org/toh/traverse/geos1_1
>=20
> I still don't actually care *enough* to try to find an ADSL line I
> could plug one into for testing though... :)


I have 3 boards lying around if anyone wants them.



