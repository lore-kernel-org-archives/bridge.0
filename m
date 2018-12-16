Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; bh=WSrJkd4DB3BQ8dRcbpjNR0M/jBee+HAtnpPgUocdS
	wc=; b=IBL53NkRL4wFtWUJ+wz82GQSfnmGZHflKjBx85iVFOJ4zwXOriqg9GoQU
	KoEvy5MV/j8IBrDUml51qUInPjI/j0oPGGIxfjm8SriTBD2LN9qA9m0eznxcan3o
	BjM4JXoN6unq4Z7zxO98uFgXiiKhyQ2IagjwhxCQf7HG/Ps48+cKmpH1wKk1vRNo
	zZq6iI5Nd7hSFqfkFcXA7tLhNaTceSi1aifIPoRTZlBLoJ3cQNsE83VvOsUFgQmF
	exT9ozJjNJz/Jd+fGc5eaBlWzMtRUlCXkR8rkXK83V2Wxa+5pbNc1nS6FgdNKcV2
	KH0pJYeRAFmV3YN5yAB8i5xLSaS7A==
Date: Sun, 16 Dec 2018 09:55:35 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20181216075535.GB27582@splinter>
References: <61ecaa9f-f1ba-f79e-1d8b-4ec2eba5dc11@gmail.com>
	<20181212090238.GA1725@splinter.mtl.com>
	<22f9700b-8cc0-b9ae-1c0d-f55ff8c8c2a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <22f9700b-8cc0-b9ae-1c0d-f55ff8c8c2a0@gmail.com>
Subject: Re: [Bridge] Correct PVID behavior with bridge's VLAN filtering
	on/off?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

On Sat, Dec 15, 2018 at 10:10:32AM -0800, Florian Fainelli wrote:
> Le 12/12/18 =E0 1:02 AM, Ido Schimmel a =E9crit=A0:
> > On Tue, Dec 11, 2018 at 11:48:21AM -0800, Florian Fainelli wrote:
> >> Hi Nikolay, Roopa, Jiri, Ido,
> >>
> >> When a bridge has vlan_filtering=3D0 and notifies a switch driver thro=
ugh
> >> HOST_OBJ_MDB about MC addresses that the CPU/management port is
> >> interested in getting MC traffic for, I am seeing that the mdb->vid is
> >> set to 0 because br_allowed_ingress() checks for BROPT_VLAN_ENABLED
> >> which is now disabled and so we never populated *vid to anything but 0
> >> because the caller: br_handle_frame_finish() zeroed it out.
> >=20
> > s/br_handle_frame_finish()/br_dev_xmit()/ ? Since you're talking about
> > HOST_OBJ_MDB
> >=20
> >> This creates a problem with the b53 DSA switch driver because in order
> >> to match the bridge's default_pvid, we did program the switch's "defau=
lt
> >> tag" to be 1, which gets used for all untagged frames that ingress the
> >> switch (which AFAICT is correct behavior for PVID).
> >=20
> > Not sure I'm following. If bridge is not VLAN-aware, then where do you
> > see 'default_pvid' being used?
> >=20
> >> Despite having turned off VLAN filtering in the switch such that it do=
es
> >> allow ingress of packets with a VID that is not present in the VLAN
> >> table (violation), Multicast addresses do behave differently and we
> >> really must be strictly matching the programmed PVID in order for MC
> >> frames to ingress the switch even with VLAN filtering turned off.
> >>
> >> So with all that being written, should the bridge still be sending MDB
> >> notifications and use the bridge's default_pvid even with
> >> vlan_filtering=3D0? And if we did that, what use case could we be poss=
ibly
> >> breaking?
> >>
> >> Let me know if this is not clear so I can provide mode details.
> >=20
> > I think you need to provide more details about the device you're working
> > with. I can explain what we're doing in mlxsw for reference.
> >=20
> > When you use a VLAN-unaware bridge w/o VLAN devices, we make sure all
> > untagged packets get tagged with some arbitrary VLAN (now 1, soon 4095).
> > You never see this VLAN on the wire, since we remove it before sending
> > the packets. It is only used because all packets in the ASIC must be
> > tagged.
> >=20
> > After we have a VLAN we classify the packet to a FID (bridge) and it
> > does {FID,DMAC} lookup in the FDB (MDB).
> >=20
> > IIUC, your problem is that you also need to tag all the packets (you
> > used '1', can be something else), but then you program the MDB entry
> > according to the VLAN passed in the notification ('0') and not use
> > ('1'). We completely ignore the VID in this case and use the FID which
> > we lookup based on the ifindex of the bridge.
> >=20
>=20
> Another thing that seems inconsistent or rather possibly problematic to
> deal with is the following:
>=20
> - create the bridge with VLAN filtering set, this leads to programming
> VLAN entries into the switch through switchdev notifications, that is
> expected and working
>=20
> - turn off VLAN filtering on that bridge, this trickles down through
> attributes notification to the switch driver which now disables ingress
> VID checking (egress directed in Broadcom B53 is not easily
> enforceable), we still have VLAN entries programmed into the switch, in
> particular, the port's default VLAN/PVID, which is contributing to my
> problem mentioned above
>=20
> - bridge is now requesting MDB programming to be done with VID=3D0 since
> the bridge is now VLAN-unaware
>=20
> One might expect that when turning off VLAN filtering, the bridge layer
> should also remove any programmed VLAN entries?

That ship has sailed :)

>=20
> In spectrum_switchdev.c an error is issued to indicate that changing
> VLAN filtering is not possible once the bridge has been created with
> VLAN filtering on initially.
>=20
> This is not necessarily something I want to restrict within B53, because
> we ought to support dynamically turning on/off VLAN filtering on the
> switch device and driver. I am not aware of an use case for that expect
> my own tests so far, but clearly we can support it, so why not.

This is really problematic to support in mlxsw. Plus, as you said, there
is no actual use case for this, so we forbid it.

> Instead of the patch I copied in my previous response where I would
> change br_allowed_ingress(), I am considering modifying the port's
> default PVID to match whatever the default VLAN is when not using a
> bridge (0 in my case) when the currently configured PVID is not that
> default PVID, conversely when re-enabling VLAN filtering, putting the
> port back on the bridge's default_pvid.
>=20
> Ido, does that make sense to you or would you advocate not to bother at
> all with that use case and do what spectrum_switchdev.c does?

That's up to you. We have been forbidding this for a long time and I
have yet to receive any complaints. But I do agree that any changes that
allow your device to work as expected belong in the device driver and
not in the bridge code.

>=20
> I would also appreciate if you could take a look at this patch since it
> would answer a lot of my questions, thank you very much!
>=20
> http://patchwork.ozlabs.org/patch/1012404/

I will check it now.

> --=20
> Florian
