Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=lx/SzwVzcARGLoh495jCv8lWxTHJtUJ0cvQwFxvLiVg=;
	b=KQ92xIJdiDNnifi6OiH2JicQ7g1w5bGkNjy/XYk5UexILmiFbgU8eI4wVcjJ7vWmRW
	Kja9B1fmsGZbbNatybFSwxOK2Jri+xug3zvP76E0gkkE53PBrN8tKH6IpvzjRdXZNbj6
	Ez7ZClQ4YZDrOpqrAPAB9P1Pn9eKGjgCzQzfM=
MIME-Version: 1.0
In-Reply-To: <20171004.155255.2208423870631197976.davem@davemloft.net>
References: <1507093953-59929-1-git-send-email-roopa@cumulusnetworks.com>
	<1507093953-59929-2-git-send-email-roopa@cumulusnetworks.com>
	<20171004.155255.2208423870631197976.davem@davemloft.net>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Thu, 5 Oct 2017 07:31:35 -0700
Message-ID: <CAJieiUi_3UxH8G1UUt1q8yQKsJC0YJr41M+q34xtS-ySkFAX=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next v4 1/3] bridge: add new
 BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org

On Wed, Oct 4, 2017 at 3:52 PM, David Miller <davem@davemloft.net> wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> Date: Tue,  3 Oct 2017 22:12:31 -0700
>
>> BR_ARP_PROXY flag but has a few semantic differences to conform
>
> This should be "BR_PROXYARP".

ack, will fix.

>
> Otherwise this series looks fine to me, but I see there will be
> a v5 respin.

yes, working on v5. I am currently testing a few more cases for
locally generated arp/nd packets with bridge as the src dev (related
to some questions from Toshiaki).

Thanks!.
