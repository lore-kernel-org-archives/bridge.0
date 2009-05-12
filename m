MIME-Version: 1.0
In-Reply-To: <20090511114639.440944109@openvz.org>
References: <20090511114639.440944109@openvz.org>
Date: Mon, 11 May 2009 23:30:33 -0600
Message-ID: <de7adc5e0905112230r60254113t6b31d8114d141be@mail.gmail.com>
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
To: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

Note: I am not a bridge guru but I'm interested in understanding this
new functionality better. What is the larger benefit of this feature?
Does this make it possible to configure a bridge setup on a remote
system without losing connectivity? I can't do many kinds of network
changes remotely without risking losing connectivity (ie. changing IP
address, messing with routing, etc. -- it would be likely that you'd
lose network connectivity :) ) Therefore, I don't know if this is a
benefit unless it is needed for a particular application. Is this
useful for OpenVZ in some way?

Regards,

Daniel

On Mon, May 11, 2009 at 5:46 AM, Cyrill Gorcunov <gorcunov@openvz.org> wrot=
e:
> Hi,
>
> here is RFC for new via_phys_dev bridge feature.
> In short -- it allows to use some bridge port as
> bridge itself with already configured routing table.
>
> More details with example you may found in patches.
>
> Please review. Any (including _complains_) comments are
> highly appreciated!
>
> The series is on top of current -net-next-2.6
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| commit ed9b58bc443a1210b5be1ded6421b17e015bf=
985
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| Author Richard Genoud <richard.genoud@gmail.=
com>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| Date Sat May 9 06:59:16 2009 +0000
>
> Cyrill
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
