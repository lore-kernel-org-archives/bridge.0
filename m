Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B812B99;
	Fri, 26 Jan 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249261; cv=none; b=FSRP3V1mJoLOvQ3laMQ4IvBApX0x2mkkb/lW2L9IJb8UNhz+3G7HgTPk4BvcopqJ44/fZ8mBsNI6B26upTS4dPILZ2DeO7GyZrWmO1fAazgkWy0BF8gIW6mLmovISK0KIQEbLtGcMgtC+RGHZ4HlLZm3TOsUaVE4X1qmPPdNFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249261; c=relaxed/simple;
	bh=lCdbp+pHkoUM7vUgFWED1lJvOrbS+WRL3qXPvADIs9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF6AfeWQ6grHbK/3fgzbg9tlwosTgrTX6eT+GLVBqpzvrV6P183Zrs4LUDhMlPdqLMDFC7QggrGz8J5+VlUvNK15VCaoeyjlEIzLYw8oPel7cINjXh+tbVuLfhZ+dqw/xvJZhPzry87KIXc5KYXAArLpe/hWZvCqgStAyQuy6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkMIBN6I; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkMIBN6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706249260; x=1737785260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lCdbp+pHkoUM7vUgFWED1lJvOrbS+WRL3qXPvADIs9A=;
  b=AkMIBN6IlGsIp99Rh+ncA1MeJmGMB5YW/wejmTlK/psAiXyS+tsmQqKM
   2WXI2H6fK5y+0mMYSaXPHba2xjEtDJ12SUeZrw4IuQZBRSg17nIE4nVUF
   lyLJ9kSwtcz8uBb2xKpkJU9LnHdo0zAesqiDdYHzPu3TTVwmvPBh4DjK1
   h9iYcejXpgWtn9bcnv4id0+3/efKXsjiLOtI4uxgWZZoFttGQed34SuS7
   vEDMHuLiX24267CiHD+rzid3gPYILBkhdNZpqB8HFNwPIGvj0uG+CqHgW
   FQZu0wj05DpNLU+xuT+xFHg0jk2UcZ/Sano4Djm5CZShCcGUg0r/luV6i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401245641"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401245641"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 22:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2519019"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Jan 2024 22:07:34 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTFND-0000kW-37;
	Fri, 26 Jan 2024 06:07:31 +0000
Date: Fri, 26 Jan 2024 14:07:27 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jiri@resnulli.us,
	ivecera@redhat.com, netdev@vger.kernel.org, roopa@nvidia.com,
	razor@blackwall.org, bridge@lists.linux.dev, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: switchdev: Relay all replay messages
 through a central function
Message-ID: <202401261325.D8Hg7ign-lkp@intel.com>
References: <20240123153707.550795-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153707.550795-4-tobias@waldekranz.com>

Hi Tobias,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tobias-Waldekranz/net-switchdev-Wrap-enums-in-mapper-macros/20240123-234801
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240123153707.550795-4-tobias%40waldekranz.com
patch subject: [PATCH net-next 3/5] net: switchdev: Relay all replay messages through a central function
config: i386-buildonly-randconfig-003-20240126 (https://download.01.org/0day-ci/archive/20240126/202401261325.D8Hg7ign-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401261325.D8Hg7ign-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261325.D8Hg7ign-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/switchdev/switchdev.c:322: warning: Function parameter or struct member 'type' not described in 'switchdev_call_replay'
>> net/switchdev/switchdev.c:322: warning: expecting prototype for switchdev_replay(). Prototype was for switchdev_call_replay() instead


vim +322 net/switchdev/switchdev.c

   309	
   310	/**
   311	 *	switchdev_replay - Replay switchdev message to driver
   312	 *	@nb: notifier block to send the message to
   313	 *	@val: value passed unmodified to notifier function
   314	 *	@info: notifier information data
   315	 *
   316	 *	Typically issued by the bridge, as a response to a replay
   317	 *	request initiated by a port that is either attaching to, or
   318	 *	detaching from, that bridge.
   319	 */
   320	int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
   321				  struct switchdev_notifier_info *info)
 > 322	{
   323		return nb->notifier_call(nb, type, info);
   324	}
   325	EXPORT_SYMBOL_GPL(switchdev_call_replay);
   326	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
