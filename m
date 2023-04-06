Return-Path: <gsomlo@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6952C60F0D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05D9F60E29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680790662;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7vagdoWVLs74/YSjQDxpvM8aXKUgVP/cIPrMpvJRI3U=;
 b=AEdRrM5sx5wSpH/Jo7wv8lWa6/vwAix2RC/BI6EHQ0zoLks9Xls9n/l3R7E5rJoF9a
 fMmftNB7rQIK9dgkYMUSm1rg6v2oQhrSbdcNwwYQwM6CoLyNsZiKV9U2xiyUyQ+T8aKs
 j5vYJM07vPNKsAmQFF4MggGWw0X+f2/TSHkhkcECSByJBTJJ39FCzg5Y4SaOr3Fq3sVS
 jSPFhCcPNKgTeOGHVKnQdPhK7lvZOVylUuBEJzZtX/SgqdjhROVvj069Etzt7sjL3ncL
 4fAwz1Hhw/0TZJR8AHAW+ZYTde9vbvV6ssitGwh0UMxCtMPKfIoBoATgFcGD10d3JJaP
 CBWg==
Date: Thu, 6 Apr 2023 10:17:40 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Message-ID: <ZC7UhHW8+82OQ5oL@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Option to forward *unconditionally* on a bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

TL;DR: Is there a way to force a bridge to forward anything and
everything on all ports (except the ingress port) *regardles* of
any permanent FDB entries (such as the MAC addresses of interfaces
acting as bridge ports)?

For context, I'm using a network-namespace (container) based simulator
(think GNS3 or CORE), which allow me to run multiple FRR instances
in their own dedicated netns, connected together by veth pairs and
bridges.

To bridge this simulation outside the machine hosting it, the
simulators allow host machine interfaces to be bridged to bridges
and veth pairs that belong to the simulation, e.g.:

 -----------------------------
 VM running simulation       |
                             |
 sim. node,                  |
 (container),                |
 dflt gateway                |
 -----------    - br0 -      |             -----------------
           |   /       \     |  inter-VM   | External VM   |
      eth0 + veth0    ens32  +-- vswitch --+ using in-sim  |
   Sim.MAC |          VM.MAC |             | dflt. gateway |
 -----------                 |             -----------------
 -----------------------------

This requires the vswitch outside of the vm hosting the simulation to
allow promiscuous mode (so that containers can send/receive Ethernet
frames through the hosting VM's interface (e.g., ens32).

It turns out that at least on one "cloudy" hosted solution the guest
VMs are forbidden from sending "spoofed" ethernet traffic, i.e. the
ens32 "vm.mac" address is strictly enforced outside the VM (on the
inter-vm vswitch).

The obvious solution would be to assign ens32's VM.MAC as the mac
address of eth0 inside the container, which would allow it to talk
on the ethernet broadcast domain bridged via br0 and the inter-vm
vswitch (assuming we only have *one* such container on the "inside").

Trouble is, br0 won't forward frames *to* VM.MAC received from
external sources, since that is a permanent FDB entry associated 
with the "ingress interface".

I'm looking to turn br0 into a "dumb hub". Typically, the closest
approximation to "hub behavior" is accomplished by disabling MAC
learning on the bridge interface(s), which will force permanent
flooding.

Turns out, the exception to that is if a mac address associated with
one of the bridge ports is involved -- no "hub" behavior in that case,
because those FDB entries aren't learned, but rather permanently
installed during bridge set-up.

Any way to override that (and ignore permanent FDB) entries would save
me a lot of effort to "hack" my way around this restriction using
multiple bridges and ebtables NAT :)

Thanks for any clue, pointers, or advice.

--Gabriel
