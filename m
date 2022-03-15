Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=PFSNAaQ3b1RcaB6X84veMT1/sBRoeUjyrqfGf9I6k
 Og=; b=bYoQ3qBUijQDWuiMSLzE4q+q+z0Gnv/45k26R0Y4upBMft9FoRm+QqoV1
 L1tAP8N8P9Z5rlqJRm3EU+5auE2ltko4YoRFav8LqT7z3zAKZYuqTql9Ywt3kJl4
 kWIxH0uZtyJSdm60O2fzzwSHjr0bp7QoxUjm8RAkWJioY9HlGFN/5Oc9YIbPTnU2
 7xBEqbuWoig5fUNRaIsF+kP9+TuJARZsIsL1rYThScoqMdPfDHC9CPZuJjmG6o5i
 5UJNrcakzAlg69TJU92fjvXKeFF/xLxT7Ts7FZKLdhok6brI6q0XMCShbIFCe4nB
 JnZNUx0Gmy6gdhu0XfF/rvUW3eVVQ==
Date: Tue, 15 Mar 2022 13:11:49 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YjB0ddhesVOEucYG@shredder>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <Yi9kTh6XZu3OiCz0@shredder> <86ee33h9q2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <86ee33h9q2.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 0/3] Extend locked port feature with
 FDB locked flag (MAC-Auth/MAB)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Tue, Mar 15, 2022 at 09:59:49AM +0100, Hans Schultz wrote:
> On m=E5n, mar 14, 2022 at 17:50, Ido Schimmel <idosch@idosch.org> wrote:
> > On Thu, Mar 10, 2022 at 03:23:17PM +0100, Hans Schultz wrote:
> >> This patch set extends the locked port feature for devices
> >> that are behind a locked port, but do not have the ability to
> >> authorize themselves as a supplicant using IEEE 802.1X.
> >> Such devices can be printers, meters or anything related to
> >> fixed installations. Instead of 802.1X authorization, devices
> >> can get access based on their MAC addresses being whitelisted.
> >>=20
> >> For an authorization daemon to detect that a device is trying
> >> to get access through a locked port, the bridge will add the
> >> MAC address of the device to the FDB with a locked flag to it.
> >> Thus the authorization daemon can catch the FDB add event and
> >> check if the MAC address is in the whitelist and if so replace
> >> the FDB entry without the locked flag enabled, and thus open
> >> the port for the device.
> >>=20
> >> This feature is known as MAC-Auth or MAC Authentication Bypass
> >> (MAB) in Cisco terminology, where the full MAB concept involves
> >> additional Cisco infrastructure for authorization. There is no
> >> real authentication process, as the MAC address of the device
> >> is the only input the authorization daemon, in the general
> >> case, has to base the decision if to unlock the port or not.
> >>=20
> >> With this patch set, an implementation of the offloaded case is
> >> supplied for the mv88e6xxx driver. When a packet ingresses on
> >> a locked port, an ATU miss violation event will occur. When
> >
> > When do you get an ATU miss violation? In case there is no FDB entry for
> > the SA or also when there is an FDB entry, but it points to a different
> > port? I see that the bridge will only create a "locked" FDB entry in
> > case there is no existing entry, but it will not transition an existing
> > entry to "locked" state. I guess ATU miss refers to an actual miss and
> > not mismatch.
> >
>=20
> On a locked port, I get ATU miss violations when there is no FDB entry
> for the SA, while if there is an entry but it is not assigned to the
> port, then I get an ATU member violation (which I have now masked on
> locked ports to limit unwanted interrupts).
>=20
> So it seems to me that my 'ATU miss' corresponds to your MISS and my
> 'ATU member' corresponds to your MISMATCH. Since I inject an entry with
> destination port vector (DPV) zero I get member violations after the
> first miss violation.

Which causes packets to be silently dropped by the device? Sounds OK, I
just want to verify I understand the behavior.

>=20
> > The HW I work with doesn't have the ability to generate such
> > notifications, but it can trap packets on MISS (no entry) or MISMATCH
> > (exists, but with different port). I believe that in order to support
> > this feature we need to inject MISS-ed packets to the Rx path so that
> > eventually the bridge itself will create the "locked" entry as opposed
> > to notifying the bridge about the entry as in your case.
> >
>=20
> This seems to me to be the way forward in your case. What kind or family
> of chips is your HW based on?

Nvidia Spectrum ASICs. Some users mentioned 802.1X support, but a
requirement never materialized so we didn't work on it.

>=20
> >> handling such ATU miss violation interrupts, the MAC address of
> >> the device is added to the FDB with a zero destination port
> >> vector (DPV) and the MAC address is communicated through the
> >> switchdev layer to the bridge, so that a FDB entry with the
> >> locked flag enabled can be added.
> >>=20
> >> Hans Schultz (3):
> >>   net: bridge: add fdb flag to extent locked port feature
> >>   net: switchdev: add support for offloading of fdb locked flag
> >>   net: dsa: mv88e6xxx: mac-auth/MAB implementation
> >
> > Please extend tools/testing/selftests/net/forwarding/bridge_locked_port=
.sh
> > with new test cases for this code.
> >
>=20
> Shall do.

Thanks!

>=20
> >>=20
> >>  drivers/net/dsa/mv88e6xxx/Makefile            |  1 +
> >>  drivers/net/dsa/mv88e6xxx/chip.c              | 10 +--
> >>  drivers/net/dsa/mv88e6xxx/chip.h              |  5 ++
> >>  drivers/net/dsa/mv88e6xxx/global1.h           |  1 +
> >>  drivers/net/dsa/mv88e6xxx/global1_atu.c       | 29 +++++++-
> >>  .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c   | 67 +++++++++++++++++++
> >>  .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h   | 20 ++++++
> >>  drivers/net/dsa/mv88e6xxx/port.c              | 11 +++
> >>  drivers/net/dsa/mv88e6xxx/port.h              |  1 +
> >>  include/net/switchdev.h                       |  3 +-
> >>  include/uapi/linux/neighbour.h                |  1 +
> >>  net/bridge/br.c                               |  3 +-
> >>  net/bridge/br_fdb.c                           | 13 +++-
> >>  net/bridge/br_input.c                         | 11 ++-
> >>  net/bridge/br_private.h                       |  5 +-
> >>  15 files changed, 167 insertions(+), 14 deletions(-)
> >>  create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c
> >>  create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h
> >>=20
> >> --=20
> >> 2.30.2
> >>=20
