DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
	b=rXw+S0dqC4p0b9J1nVkpSrkMLG0TZ6svrWjvJlxM8kN6WSJaHV8Hgn/wC6G4x1oENEmbMWbYIULQZQRrUI5fdTiTzG5ciYL/pZaoRvXopuqgzEpIuCKzJn2N+E5ghMC7gxtQ9qKFkytAFmcUs3xK2i1hQbOZRMBkKAZ053CqGzA=
Message-ID: <58e46d120708150127o6cc0b487x1b6563016cb4716a@mail.gmail.com>
Date: Wed, 15 Aug 2007 11:27:42 +0300
From: "Vassil Panayotov" <vassil.panayotov@gmail.com>
Subject: [Bridge] Re: Reset of setpathcost after link comes back up
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Lars Braeuer <lb@mpexnet.de>
Cc: bridge@lists.linux-foundation.org

Hi,
> In a redundant setup (2 bridges), I usally set the path cost of external ports
> to 1 und internal ports to 100. So that the external port of the backup bridge
> is in forwarding and the internal port in blocking state.
>

If my understanding of STP is correct you can achieve the same result
by setting port priorities on the designated bridge's ports.

> But, when the physical link goes down and comes back up (i.e. link failure or
> cable unplug and replug) the path cost of the links automatically reset to
> values like 4 and 19.
>
> Is this a desired behaviour, shouldn't the path cost remain at the values specified?

IMO this is the desired behaviour - the port path cost is recalculated
every time when link state change is detected, probably to accommodate
to possible link speed change.

> I'm using bridge support in Kernel 2.6.19. As I can't test a new Kernel yet, I'm
> just asking if this might be a bug and maybe someone knows if this has been
> fixed lately?
>
> Thanks in advance.
>
> Best,
>
> Lars

I am by no means an expert in the bridging code(and in kernel coding
in general) but it seems that the "fix" bellow will "solve" your
problem. But this is definitely not the right way to do it :)

Regards,
Vassil

--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -89,9 +89,6 @@ static void port_carrier_check(void *arg)
                goto done;
        br = p->br;

-       if (netif_carrier_ok(dev))
-               p->path_cost = port_cost(dev);
-
        if (br->dev->flags & IFF_UP) {
                spin_lock_bh(&br->lock);
                if (netif_carrier_ok(dev)) {
