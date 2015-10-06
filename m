Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=+bREZGAnOzCVHd0/2EedFAsP6XCEE6I2DHy6NDZ6TZI=;
	b=Ieg3Hx1r2XMCVe1WidBmFV2gVGrTc+o0vPTz9uYKn7DcDVzZmnsf2gJ0fvrf0Sl5FS
	GyEZ26igHWbAVuXH5YEzulo7TTS0t4sKoUsDRTqdVyEYtLbCJ9LhCL6rnN5MGuQBZblU
	9T8YmHhJOxafO29ZnpJ9wQ/Zu2D0H11ZUELMA=
References: <201510062037.Kw9qnttB%fengguang.wu@intel.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5613C1D5.80702@cumulusnetworks.com>
Date: Tue, 6 Oct 2015 14:43:01 +0200
MIME-Version: 1.0
In-Reply-To: <201510062037.Kw9qnttB%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/8] bridge: netlink: export port's
	root id
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kbuild test robot <lkp@intel.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: shm@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, kbuild-all@01.org, davem@davemloft.net

On 10/06/2015 02:30 PM, kbuild test robot wrote:
> Hi Nikolay,
> 
> [auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]
> 
> config: x86_64-randconfig-x016-201540 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    net/bridge/br_netlink.c: In function 'br_port_info_size':
>>> net/bridge/br_netlink.c:116:27: error: invalid application of 'sizeof' to incomplete type 'struct ifla_bridge_id'
>       + nla_total_size(sizeof(struct ifla_bridge_id)) /* IFLA_BRPORT_ROOT_ID */
>                               ^
>    net/bridge/br_netlink.c: In function 'br_port_fill_attrs':
>    net/bridge/br_netlink.c:151:47: error: invalid application of 'sizeof' to incomplete type 'struct ifla_bridge_id'
>          nla_put(skb, IFLA_BRPORT_ROOT_ID, sizeof(struct ifla_bridge_id),
>                                                   ^
>    net/bridge/br_netlink.c: In function 'br_port_info_size':
>>> net/bridge/br_netlink.c:118:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }
>     ^

This is incorrect, the structure is in net-next. My previous set introduced it:
commit 5127c81f84de ("bridge: netlink: export root id")

Cheers,
 Nik


