Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XrzCwVrtEX9x0THn4fYV5Kz9vwxRpEBYKWI4W7K8u3I=;
	b=xcHuBFUI5k335gGr4TiRo733QpFVghbsfJ7lF5B2kF3gduX95P9/bOi6mzRLNGU6is
	g633nPfar6guQQi6sSfvL7WQTb8P58c+OA6QBMbDuwGcPYw1MIfKCxRI0KnGHAI3KpyR
	WvkOm3uab9RCJmkkLGKNZSUvJ8Tf8P9Seg717W8P85xNuJ9CBf2ZJN4TBjxcXLrrst51
	GqOaSj6uMl0kzQVfJv02PX0bOLAbDWdCF4hqWWf57WCz3Aguowj7rJwf0Bitfjhui1fX
	p2ug3xWDnXAfipbJI9l7Rrifju+XtZVwz/+XNj8hzS2gBl80F9XBcy3UqtRhRPVqTeiT
	VAGw==
Date: Mon, 2 Oct 2017 11:02:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171002110224.4d789600@xeon-e3>
In-Reply-To: <CAJieiUim2XLMGAomb3S5AeWfYqjxV_raetedWcA_PBiaGPRHWg@mail.gmail.com>
References: <1506919018-27875-1-git-send-email-roopa@cumulusnetworks.com>
	<CAJieiUim2XLMGAomb3S5AeWfYqjxV_raetedWcA_PBiaGPRHWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "davem@davemloft.net" <davem@davemloft.net>

On Mon, 2 Oct 2017 07:49:09 -0700
Roopa Prabhu <roopa@cumulusnetworks.com> wrote:

> On Sun, Oct 1, 2017 at 9:36 PM, Roopa Prabhu <roopa@cumulusnetworks.com> wrote:
> > From: Roopa Prabhu <roopa@cumulusnetworks.com>
> >
> > This series implements arp and nd suppression in the bridge
> > driver for ethernet vpns. It implements rfc7432, section 10
> > https://tools.ietf.org/html/rfc7432#section-10
> > for ethernet VPN deployments. It is similar to the existing
> > BR_ARP_PROXY flag but has a few semantic differences to conform
> > to EVPN standard. In case of EVPN, it is mainly used to avoid flooding to
> > tunnel ports like vxlan/mpls. Unlike the existing flags it suppresses flood
> > of all neigh discovery packets (arp, nd) to tunnel ports.
> >
> > Roopa Prabhu (3):
> >   bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd
> >     flood
> >   neigh arp suppress first
> >   bridge: suppress nd messages from going to BR_NEIGH_SUPPRESS ports
> >  
> 
> pls ignore, shows conflict applying over recent net-next bridge
> changes. Will rebase and submit v2.

Ok, but the concept looks good.
