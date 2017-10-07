Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=x+kjXOZuIXy8BZcbgBX8Et1ajwDzQ9LUmwH5VJXdDOg=;
	b=aBvqegfZn+tzdDLnHeScDrP1r1FxAH/gA5X0SrZGYuWb1zxuBO+nd+TD3Jq2nejsWT
	IL2QoMHi0qia6wHTTv9Q5ICKEi1NL8fNWagsKjqqRAWKJypMRzALBUiMS7V4XftQyF2W
	04yJhKtlyzJz01X4nGPMfjUu1f2drJBSdUrZ0=
MIME-Version: 1.0
In-Reply-To: <1507314880-16310-1-git-send-email-roopa@cumulusnetworks.com>
References: <1507314880-16310-1-git-send-email-roopa@cumulusnetworks.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Fri, 6 Oct 2017 19:35:27 -0700
Message-ID: <CAJieiUhec_RU3ncjYd-PjUkduvmprwXmj-9S7Uy1LKSD4dzbAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next v5 0/3] bridge: neigh msg proxy and
 flood suppression support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "davem@davemloft.net" <davem@davemloft.net>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org

On Fri, Oct 6, 2017 at 11:34 AM, Roopa Prabhu <roopa@cumulusnetworks.com> wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
>
> This series implements arp and nd suppression in the bridge
> driver for ethernet vpns. It implements rfc7432, section 10
> https://tools.ietf.org/html/rfc7432#section-10
> for ethernet VPN deployments. It is similar to the existing
> BR_PROXYARP* flags but has a few semantic differences to conform
> to EVPN standard. Unlike the existing flags, this new flag suppresses
> flood of all neigh discovery packets (arp and nd) to tunnel ports.
> Supports both vlan filtering and non-vlan filtering bridges.
>
> In case of EVPN, it is mainly used to avoid flooding
> of arp and nd packets to tunnel ports like vxlan.
>
> v2 : rebase to latest + address some optimization feedback from Nikolay.
> v3 : fix kbuild reported build errors with CONFIG_INET off
> v4 : simplify port flag mask as suggested by stephen
> v5 : address some feedback from Toshiaki
>

Looks like I missed applying a cleanup done in v5 to the ipv6 nd path.
Dave, I see these patches 'under review' in patchworks. If its not too
late, pls drop them. I will spin v6 in a few hrs. thanks.
