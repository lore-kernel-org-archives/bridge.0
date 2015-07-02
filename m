Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=QzpRigpIEI9TsCVg75JTW7gUoYvP0LNvyaXYy/lyN9I=;
	b=Ck+QrPOGTOyLpR16LxGd5/g+wlks2OdozKB3uC0rJ3m6uXzq9LAzcx25i1pZFAZe0c
	s84805HQu7Zxh6xMAxNvqBlkDX8op+CoePh9NzEAEMWt9RJvujMV5dD6WwtxKKfw4hVE
	4LzqDWMo9PEYCBGWZiqQbMJn3S6663+iIOrEPnBincgGFsECAJFuKUqOdUPmNSoSPvnt
	E4l9a3Znj0Pjm+CTMAoWZZxlwNXG2PbGMIepLwWppbPQdAyOiH/R8FWNucB1XsUarCLu
	QgLnV0dmaf1Bpa7r+lkmSTJyV7ijAwBDTgIpXboQOf659zvp6vZChN9Mklj71xYHSAL9
	2/XQ==
Message-ID: <55955CCF.4020106@gmail.com>
Date: Fri, 03 Jul 2015 00:46:23 +0900
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
MIME-Version: 1.0
References: <1435841297-44200-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1435841297-44200-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: vlan: fix usage of vlan 0 and 4095
	again
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, vyasevich@gmail.com, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@cumulusnetworks.com

On 15/07/02 (木) 21:48, Nikolay Aleksandrov wrote:
> Vlan ids 0 and 4095 were disallowed by commit:
> 8adff41c3d25 ("bridge: Don't use VID 0 and 4095 in vlan filtering")
> but then the check was removed when vlan ranges were introduced by:
> bdced7ef7838 ("bridge: support for multiple vlans and vlan ranges in setlink and dellink requests")
> So reintroduce the vlan range check.
> Before patch:
> [root@testvm ~]# bridge vlan add vid 0 dev eth0 master
> (succeeds)
> After Patch:
> [root@testvm ~]# bridge vlan add vid 0 dev eth0 master
> RTNETLINK answers: Invalid argument
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Fixes: bdced7ef7838 ("bridge: support for multiple vlans and vlan ranges in setlink and dellink requests")

Thank you for fixing this.

Acked-by: Toshiaki Makita <toshiaki.makita1@gmail.com>
