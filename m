Return-Path: <sfeldma@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=DovALg2p8bIB47lCkNIWZ4LexNoceC2FakLWd2xhH8A=;
	b=uw0vAe9TwYstqOcseckSzQzgBwRZ6nYrdtwkPMH39/xDV0Wx9H7UhFGMQ1wS0HG13s
	vp17ATUZmpIgUm5xUE9RY+1kZnc/8rSeO5+UvUgsPUsdSQiUV/NXQLCHiYF3vBBr6kzU
	s1r11RSDzL2pn0IAv8v4+xSNgI49P+eGLT8XfYvVFx7iTMZkwA7qkka7w3XUGejDOtCD
	hi6VuXhBF3bqj5liecQyPkJFeIBk3s7dfXazoSCVrSFuN7OiMZpzNJ9GkIW7xCseAZgU
	0BQCVRaG++9dhqRMgRSxnjf3SWg7Y0H+ItsHbmNu7OopbIAdHGUqAAM9kWO+w9/bKfUt
	rrTg==
MIME-Version: 1.0
In-Reply-To: <20151012175156.GA16784@colbert.mtl.com>
References: <1444650069-32572-1-git-send-email-razor@blackwall.org>
	<1444650069-32572-5-git-send-email-razor@blackwall.org>
	<20151012175156.GA16784@colbert.mtl.com>
From: Scott Feldman <sfeldma@gmail.com>
Date: Mon, 12 Oct 2015 23:41:33 -0700
Message-ID: <CAE4R7bCNFAOPjf19DgGYmLChds6z5NmSYG5qmqAXGKYHySh-PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net-next 4/4] bridge: vlan: combine
 (br|nbp)_vlan_flush into one
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: bridge@lists.linux-foundation.org, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Netdev <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Shrijeet Mukherjee <shm@cumulusnetworks.com>, "David S. Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@cumulusnetworks.com>

On Mon, Oct 12, 2015 at 10:51 AM, Ido Schimmel <idosch@mellanox.com> wrote:
> Mon, Oct 12, 2015 at 02:41:09PM IDT, razor@blackwall.org wrote:
>>From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>
>>As Ido Schimmel pointed out the vlan_vid_del() loop in nbp_vlan_flush is
>>unnecessary (and is actually a remnant of the old vlan code) so we can
>>remove it and combine both br/nbp vlan_flush functions into one.
> Just a small note to Scott and Vivien:
>
> One of the side effects of Nik's recent patchsets is that when VLANs are
> flushed on a port the deletion is propagated to the driver via
> switchdev ops, as __vlan_vid_del is called.
>
> Therefore there is no need to do internal bookkeeping and remove VLANs
> yourself when port is removed from bridge.

Thanks for the heads-up.  Seems like a nice result.
