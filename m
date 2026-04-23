Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C001B142D
	for <bridge@lists.linux.dev>; Thu, 23 Apr 2026 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930822; cv=none; b=etPX1SBUfxFMT8qlV9O3YVHvimqFfPaUUsQp7oxtrzXc9TUVZvZl1BWUFO7Khj5YjVq1S8hDmkEHDfB7bXz9mE/1hpeX8ipSVAiE2Onl2FMoL3BUkiTHWBsZjwMWvxKgeUxCKzF0OiDocX3YAS8iRswug/FXs6le/oEJ5rEOAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930822; c=relaxed/simple;
	bh=4Q3alcc3k9cVvnJzyMRTqGyURqykgMXdDEUAJ0yJG/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1yZghC68gkHwqy7nfKcpJmq1gvwgyTzVbHah0lnBYvnvWa2RgCjyho0Fuqx4Sy0lcGBJ5+aHfy4txZdNrat2d6flm7dx5OgX0iohuUE1NY4aV8XElYL3OYIsgecHAXBBKCDjT63wgn0I8i5zhrjZskjUmSXZxqqks/A7b//n1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVpDAZ7/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVpDAZ7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776930821; x=1808466821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4Q3alcc3k9cVvnJzyMRTqGyURqykgMXdDEUAJ0yJG/0=;
  b=bVpDAZ7/7y5Eag/I4D+MOR2CD/y8gPkmUw+Gg5VTEycvp/GNpR+6oBZO
   5ILzjhzTGj+kI8a/0JeIJocDG3g5gMhhGiFbakn3JjfAZiJBCXmNT2YqJ
   NHyJwMWTvW9L2EvJFCAr+yG2DeVKomdUDLULOUNSyA6UR4+EpC+AIuoQV
   UYjk9TPs7eNikoSbdWNWVqHWUViAaK72iHQlbT47PoVtXaTZ96FeLoqhd
   wxP3GCySAaCOhuX/k8yQk6cQeVQZEOAj3kX7pygkCS1yo3Eno9Fy2a8gB
   L6uHWJUpFjCF4jfKxxxj9LlYEXsZ+Mp4RAL62ftuJXamyjUvnvY/xs0bi
   A==;
X-CSE-ConnectionGUID: y7sekUqeTue2T8kGk4Iz5g==
X-CSE-MsgGUID: iU5LRPzuT462FzfYFBIqvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77595750"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77595750"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:53:41 -0700
X-CSE-ConnectionGUID: oloRMtPmSCax/2pqcSRMMA==
X-CSE-MsgGUID: 6a5xSc8VTxmeZrNbkaejHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="236952191"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:53:31 -0700
Date: Thu, 23 Apr 2026 10:53:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	openwrt-devel <openwrt-devel@lists.openwrt.org>,
	Guy Ellis <guy@traverse.com.au>, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux@armlinux.org.uk, tsbogend@alpha.franken.de,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org,
	idosch@nvidia.com, jani.nikula@intel.com, mchehab+huawei@kernel.org,
	tytso@mit.edu, herbert@gondor.apana.org.au, geert@linux-m68k.org,
	ebiggers@kernel.org, johannes.berg@intel.com,
	jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com,
	fourier.thomas@gmail.com, rdunlap@infradead.org,
	akpm@linux-foundation.org, linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <aenP-TVgF-PrayEu@ashevche-desk.local>
References: <20260422041846.2035118-1-kuba@kernel.org>
 <accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
 <68316F0B-2442-4492-A041-E57EFC58AC08@redfish-solutions.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68316F0B-2442-4492-A041-E57EFC58AC08@redfish-solutions.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 08:41:27PM -0600, Philip Prindeville wrote:
> > On Apr 22, 2026, at 7:05 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Tue, 2026-04-21 at 21:18 -0700, Jakub Kicinski wrote:

...

> >>    I'm still deleting the solos driver, chances are nobody uses it.
> >>    Easy enough to revert back in since core is still around.
> >>    The guiding principle is to keep USB modems and delete
> >>    the rest as USB ADSL2+ CPEs were most popular historically.
> > 
> > Still not entirely convinced; I worked on both USB ATM modems and on
> > Solos, and the Solos is both the most modern and the only one I still
> > actually have. And the only one we have native support for that could
> > ever do full 24Mb/s ADSL2+, I believe.
> > 
> > If we drop it, OpenWrt will need to drop support for these, which I
> > think were quite popular at the time; there were a few UK resellers:
> > https://openwrt.org/toh/traverse/geos1_1
> > 
> > I still don't actually care *enough* to try to find an ADSL line I
> > could plug one into for testing though... :)
> 
> I have 3 boards lying around if anyone wants them.

The problem as I understand it is in one's willing to maintain and
support that driver while doing regular testing...

-- 
With Best Regards,
Andy Shevchenko


