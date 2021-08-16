Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=my+NVrFi3SMEh1O+1a7VE5Q2gtSPMN9s0XFCWqu01mk=;
 b=ulpd+rkNp3kQpi2sCNtBYRMVVzxznO0I85WInZN74+BnJJXTdU84MI67e6hAwQIezxcS
 Ai2xvid5w/Fhg6qvqMznVU7RIvmOvEuDAv1kNdMPR1DTM5SQer9fU2ftdgjPzPShI9EZ
 fKAMaAA37W93bj5gcAXfdiIdhS+j+9vw+Fxbr6Kkad2IehlKdFa0oA+EFCwhblu5Uxtw
 6p65iuFQwYO5d2VEKDR234cYtkcjhK9VmAdgjFstc4R0zVWtH1k7HFWqTwB1mjxadev+
 AFyYpyLWdl5sTY0nZ7t3JZYU/0tXHbHi+xQDXUxwOrH9Sj4pLoeBs/+7+0NgyzR5/uHR EA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=my+NVrFi3SMEh1O+1a7VE5Q2gtSPMN9s0XFCWqu01mk=;
 b=wrzSfe8lMTZEYYZ/0vi4T7sVb2VJ94XBZqC5bV0FSmeCZDeeome0mt8vouGFBHoHqfCm
 2xq1o0EKkqsw4EHgd4+E6EeOll3f392IlUM6pUrzuGiUnXc5kxIAS+/GPhQPUxb9c2zf
 EP/86rWq7pbplE02UanvNzUXukIVipjzcBjNvunebXFIqarvCpMkw79O5xiCSzmW7XTr
 E/IkiJSJkIHXmyf0u4jzMnnGlL7uDm4JFhU6QoiW0Ero4/GjUua9n7mHu4xROpq2A+NR
 6Zs0N9WU45wFeg+4IozhFB/wNtpx31kJLjbelbLDWWWM3hpHk/dJxfsF3PUXrQvWBCzS uA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my+NVrFi3SMEh1O+1a7VE5Q2gtSPMN9s0XFCWqu01mk=;
 b=hPveWfUAjFy0NHFVBTL87XDWk5NBaqBwMbVqnmgpFPHh4BeUtQCt1x60cVdpkbCV9oUz2DcXeWb4+EhsUjQHI8kREgPryRuBuT4XZ1LS6GAs0481ZnJPlbHCP7QKkOIIPcG+54XEZw6SoInwhNv2XF123UqM9EuUUzIa+2FT0Jw=
Date: Mon, 16 Aug 2021 11:33:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <202108140311.dorJxbPR-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813150002.673579-5-razor@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 4/6] net: bridge: mcast: dump ipv4
	querier state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kbuild@lists.01.org, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, kbuild-all@lists.01.org, lkp@intel.com, roopa@nvidia.com

Hi Nikolay,

url:    https://github.com/0day-ci/linux/commits/Nikolay-Aleksandrov/net-bridge-mcast-dump-querier-state/20210813-230258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git b769cf44ed55f4b277b89cf53df6092f0c9082d0
config: x86_64-randconfig-m001-20210814 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/bridge/br_multicast.c:2931 br_multicast_querier_state_size() warn: sizeof(NUMBER)?

vim +2931 net/bridge/br_multicast.c

384d7e0455593b Nikolay Aleksandrov 2021-08-13  2929  size_t br_multicast_querier_state_size(void)
384d7e0455593b Nikolay Aleksandrov 2021-08-13  2930  {
384d7e0455593b Nikolay Aleksandrov 2021-08-13 @2931  	return nla_total_size(sizeof(0)) +      /* nest attribute */
                                                                              ^^^^^^^^^
This looks like it's probably intentional, but wouldn't it be more
readable to say sizeof(int) as it does below?

384d7e0455593b Nikolay Aleksandrov 2021-08-13  2932  	       nla_total_size(sizeof(__be32)) + /* BRIDGE_QUERIER_IP_ADDRESS */
384d7e0455593b Nikolay Aleksandrov 2021-08-13  2933  	       nla_total_size(sizeof(int)) +    /* BRIDGE_QUERIER_IP_PORT */
384d7e0455593b Nikolay Aleksandrov 2021-08-13  2934  	       nla_total_size_64bit(sizeof(u64)); /* BRIDGE_QUERIER_IP_OTHER_TIMER */
384d7e0455593b Nikolay Aleksandrov 2021-08-13  2935  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

