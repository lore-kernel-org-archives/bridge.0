MIME-Version: 1.0
In-Reply-To: <20090512162432.GA12820@lenovo>
References: <20090511114639.440944109@openvz.org>
	<de7adc5e0905112230r60254113t6b31d8114d141be@mail.gmail.com>
	<aa79d98a0905112319k6bc19ebk60a6458165b8c0a1@mail.gmail.com>
	<de7adc5e0905120002o7f19a1eepe0397d698c08ce97@mail.gmail.com>
	<20090512162432.GA12820@lenovo>
Date: Tue, 12 May 2009 11:07:14 -0600
Message-ID: <de7adc5e0905121007t74ba52e2j9a98b998540e7df9@mail.gmail.com>
From: Daniel Robbins <drobbins@funtoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [RFC 0/5] bridge - introduce via_phys_dev feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

On Tue, May 12, 2009 at 10:24 AM, Cyrill Gorcunov <gorcunov@gmail.com> wrot=
e:
> So, Daniel, i think the right question is -- do I ever need to
> configure/setup bridge remotely? I suppose yes, it happens.
> (at least I had a machine with lack of input device except a few
> =C2=A0NICs :-)

Aha, yes it would be useful in that case :)

So is the idea that you use via_phys_dev *temporarily* when
configuring the bridge, then you get it set up the way you want, and
then maybe you reboot the machine, and this time leave via_phys_dev
off? Or are there certain cases you can envision where you might want
this enabled permanently?

> This feature already was in OpenVZ 2.6.24 kernel. I'm more intiresting in
> usefulness of this feature for the mainline. (in short -- we use it for b=
ridging
> VEs with eth0 as a master device so all works without needing to
> reconfigure routing table). Moreover, since bridge already support
> namespacing the feature could be usefull for lxc as well (though
> didn't check to be fair).

But not in the OpenVZ 2.6.27-briullov kernel yet, at least the one I'm
running :)

> That is why it's RFC so people could decide should it be included
> into mainline or not. Worth it so or not.

If it is accepted into mainline, be sure to send Stephen some
documentation on this feature so he can add it to the net:bridge docs.
When features like this aren't documented, no one knows how to use
them. I just ran into this issue with the 2.6.27+ "sticky" bridge MAC
feature. I'd also be willing to help keeping the bridge docs
up-to-date. Please let me know if you or Stephen want me to do this.
Bridging is really important for OpenVZ and other
container/paravirtualization technologies so keeping docs up-to-date
is becoming more important. It can be useful to have a
non-kernel-developer like me document the functionality.

Best Regards,

Daniel
