Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=POQM7dXsk8D4ZnT12p3valfq+lPfR7rDLa4k08YAkQg=;
	b=LCv4cWycfgmkBrMG1rbD18wN6+koH3obD0agqGD8zwouSol65EAAE5gn+NaWy393f1
	viRO7lEI3eQXUdMkr+oCkYssr5ebwem0hs5D7KeVaHTVffRLQrY9KXY1qBq5iamI5u3M
	O4sDncaZvAs42Gl++C01rAuOshVQ5GKoTpATU=
MIME-Version: 1.0
In-Reply-To: <1506919018-27875-1-git-send-email-roopa@cumulusnetworks.com>
References: <1506919018-27875-1-git-send-email-roopa@cumulusnetworks.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Mon, 2 Oct 2017 07:49:09 -0700
Message-ID: <CAJieiUim2XLMGAomb3S5AeWfYqjxV_raetedWcA_PBiaGPRHWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next 0/3] bridge: neigh msg proxy and flood
 suppression support
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

On Sun, Oct 1, 2017 at 9:36 PM, Roopa Prabhu <roopa@cumulusnetworks.com> wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
>
> This series implements arp and nd suppression in the bridge
> driver for ethernet vpns. It implements rfc7432, section 10
> https://tools.ietf.org/html/rfc7432#section-10
> for ethernet VPN deployments. It is similar to the existing
> BR_ARP_PROXY flag but has a few semantic differences to conform
> to EVPN standard. In case of EVPN, it is mainly used to avoid flooding to
> tunnel ports like vxlan/mpls. Unlike the existing flags it suppresses flood
> of all neigh discovery packets (arp, nd) to tunnel ports.
>
> Roopa Prabhu (3):
>   bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd
>     flood
>   neigh arp suppress first
>   bridge: suppress nd messages from going to BR_NEIGH_SUPPRESS ports
>

pls ignore, shows conflict applying over recent net-next bridge
changes. Will rebase and submit v2.
