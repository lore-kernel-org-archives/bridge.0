Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps1;
 bh=qfFV0mBBaebNMiSdG6/zxd/ozUwo+Yf0EEBddPBfpWc=;
 b=hPKJMSnUwBT7FMG3dFfmRtDWBSmfqyKKSUXuNBrnj1N5Swf9aWWM7d6HqPd0QWiYta0F
 5tspmMbdtvkid6uBLN9CRITWoel4nmCgV6FhLeq8SjmG4y58ouI32ldSBst3RnAa8N6f
 VXRZUvCvqXuBQxsQ1G4dkI4La0Ms7FCH0mTAmO2UvEifQ36N4GX2wWrgUU/MwQWplOLc
 uXWdErY32Oq6jMcqW722MW6tClfURzR7LXD/uJyt48wvaTCyReaPvUxXncWdz2zwv4+5
 CAvyudZiM6ZuDggSadf6E4tDRDgi/WfsWaDYr0Q8OgvU9CHDvDIbX+AN3tJtSCwj14jS 7Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfFV0mBBaebNMiSdG6/zxd/ozUwo+Yf0EEBddPBfpWc=;
 b=JVUkMwiRHpmv+LpYmfeiUDH85wSzAlNwlE997nvGsi2Aq0o/BoN88Uv4AN40gIXAsOwA+c047h8JtNyHRBdk9D5coz4dSbthedOUBiEG/OOvgwnR4f02UB7c7h+ILjC2TVE8NujPELUmh/Cz6+NM0hQ+swE/BlZgSjyLalYgreoJZ/df5PQOinS5TQ1q69a8tb/Xhmkgoouwrray2oi3ZtCt2sYvO8x24OxnKS/w63k0z9OGAarP7nMDgKHiE7dIYewOUfdSefjsg9s8eiAxE7H5jvlIFNStJT+43IFmrxF4KeJl6Ez1u8baV9TfruqlsFWBfE4LZe3hu2gr2U+vQg==
From: "Huang, Joseph" <Joseph.Huang@garmin.com>
Date: Tue, 4 May 2021 23:26:09 +0000
Message-ID: <82693dbedd524f94b5a6223f0287525c@garmin.com>
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>
 <6fd5711c-8d53-d72b-995d-1caf77047ecf@nvidia.com>
 <685c25c2423c451480c0ad2cf78877be@garmin.com>, <87v97ym8tc.fsf@waldekranz.com>
In-Reply-To: <87v97ym8tc.fsf@waldekranz.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net 0/6] bridge: Fix snooping in multi-bridge
 config with switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@idosch.org>

> If I may make a suggestion: I also work with mv88e6xxx systems, and we
> have the same issues with known multicast not being flooded to router
> ports. Knowing that chipset, I see what you are trying to do.
>=20
> But other chips may work differently. Imagine for example a switch where
> there is a separate vector of router ports that the hardware can OR in af=
ter
> looking up the group in the ATU. This implementation would render the
> performance gains possible on that device useless. As another example, yo=
u
> could imagine a device where an ATU operation exists that sets a bit in t=
he
> vector of every group in a particular database; instead of having to upda=
te
> each entry individually.
>=20
> I think we (mv88e6xxx) will have to accept that we need to add the proper
> scaffolding to manage this on the driver side. That way the bridge can st=
ay
> generic. The bridge could just provide some MDB iterator to save us from
> having to cache all the configured groups.
>=20
> So basically:
>=20
> - In mv88e6xxx, maintain a per-switch vector of router ports.
>=20
> - When a ports router state is toggled:
>   1. Update the vector.
>   2. Ask the bridge to iterate through all applicable groups and update
>      the corresponding ATU entries.
>=20
> - When a new MDB entry is updated, make sure to also OR in the current
>   vector of router ports in the DPV of the ATU entry.
>=20
>=20
> I would be happy to help out with testing of this!

Thanks for the suggestion/offer!

What patch 0002 does is that:

- When an mrouter port is added/deleted, it iterates over the list of mdb's
  to add/delete that port to/from the group in the hardware (I think this i=
s
  what your bullet #2 does as well, except that one is done in the bridge,
  and the other is done in the driver)

- When a group is added/deleted, it iterates over the list of mrouter ports
  to add/delete the switchdev programming

I think what Nik is objecting to is that with this approach, there's now
a for-loop in the call paths (thus it "increases the complexity with 1 orde=
r
of magnitude), however I can't think of a way to avoid the looping (whether
done inside the bridge or in the driver) but still achieve the same result
(for Marvell at least).

I suspect that other SOHO switches might have this problem as well (Broadco=
m
comes to mind).

Thanks,
Joseph=
