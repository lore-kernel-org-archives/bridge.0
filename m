Date: Tue, 12 May 2009 21:21:36 +0400
From: Cyrill Gorcunov <gorcunov@gmail.com>
Message-ID: <20090512172136.GC12820@lenovo>
References: <20090511114639.440944109@openvz.org>
	<de7adc5e0905112230r60254113t6b31d8114d141be@mail.gmail.com>
	<aa79d98a0905112319k6bc19ebk60a6458165b8c0a1@mail.gmail.com>
	<de7adc5e0905120002o7f19a1eepe0397d698c08ce97@mail.gmail.com>
	<20090512162432.GA12820@lenovo>
	<de7adc5e0905121007t74ba52e2j9a98b998540e7df9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <de7adc5e0905121007t74ba52e2j9a98b998540e7df9@mail.gmail.com>
Subject: Re: [Bridge] [RFC 0/5] bridge - introduce via_phys_dev feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Daniel Robbins <drobbins@funtoo.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

[Daniel Robbins - Tue, May 12, 2009 at 11:07:14AM -0600]
| On Tue, May 12, 2009 at 10:24 AM, Cyrill Gorcunov <gorcunov@gmail.com> wr=
ote:
| > So, Daniel, i think the right question is -- do I ever need to
| > configure/setup bridge remotely? I suppose yes, it happens.
| > (at least I had a machine with lack of input device except a few
| > =A0NICs :-)
|=20
| Aha, yes it would be useful in that case :)
|=20
| So is the idea that you use via_phys_dev *temporarily* when
| configuring the bridge, then you get it set up the way you want, and
| then maybe you reboot the machine, and this time leave via_phys_dev
| off? Or are there certain cases you can envision where you might want
| this enabled permanently?

You could turn this feature on while configuring bridge, then as only
you have done all you need you just turn it off and bridge back to its
regular behaviour (and remote connection lost of course). So no need
for reboot. At moment sysfs entry is added and ioctls as well (though
bridge utils need some change to support new ioctls).

Permanently... it could be usefull if you initially planned to have remote
access to bridge-master machine. Ie instead to set up IP for bridge
device you remain with master device IP (say eth0).

|=20
| > This feature already was in OpenVZ 2.6.24 kernel. I'm more intiresting =
in
| > usefulness of this feature for the mainline. (in short -- we use it for=
 bridging
| > VEs with eth0 as a master device so all works without needing to
| > reconfigure routing table). Moreover, since bridge already support
| > namespacing the feature could be usefull for lxc as well (though
| > didn't check to be fair).
|=20
| But not in the OpenVZ 2.6.27-briullov kernel yet, at least the one I'm
| running :)

it's just a quiestion of time :)

|=20
| > That is why it's RFC so people could decide should it be included
| > into mainline or not. Worth it so or not.
|=20
| If it is accepted into mainline, be sure to send Stephen some
| documentation on this feature so he can add it to the net:bridge docs.
| When features like this aren't documented, no one knows how to use
| them. I just ran into this issue with the 2.6.27+ "sticky" bridge MAC
| feature. I'd also be willing to help keeping the bridge docs
| up-to-date. Please let me know if you or Stephen want me to do this.
| Bridging is really important for OpenVZ and other
| container/paravirtualization technologies so keeping docs up-to-date
| is becoming more important. It can be useful to have a
| non-kernel-developer like me document the functionality.

Of course, though with my english better to not touch docs :)

But again -- this series requires _strong_ review and testing
(since I'm not a netdevel expert)

|=20
| Best Regards,
|=20
| Daniel
|=20
	-- Cyrill
