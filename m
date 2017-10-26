Return-Path: <Viraj.Raiyani@dell.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
	t=1509039231; x=1540575231;
	h=from:to:subject:date:message-id:references:in-reply-to:
	content-transfer-encoding:mime-version;
	bh=6xkr5YYgcfAcHeeFdSou8HKpnfm/yvDhZnuctc1cOfQ=;
	b=Gi5O5DQROa7V5Ru9cAUiI4GAA7aRmwsMmYD8HgodwORrGNe52iY08Zy3
	RG3OFLechW3rpmYHKyQ3XxDrWSRLvv0zIc3y5JBPpFbJwBus5SkmVB5rF
	2AXKTCfjwZleLwd+au5qFSr4+bvNNCZRts68r6K4/bfXD7XKKg7jFp/aQ c=;
From: <Viraj.Raiyani@dell.com>
Date: Thu, 26 Oct 2017 17:33:49 +0000
Message-ID: <1509039231788.24944@Dell.com>
References: <1508950038625.54184@Dell.com>,
	<8ac43814-70e8-81dc-767d-3981d1547ec8@lab.ntt.co.jp>
In-Reply-To: <8ac43814-70e8-81dc-767d-3981d1547ec8@lab.ntt.co.jp>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] Linux Bridge Static FDB move
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp, bridge@lists.linux-foundation.org

Thank you for the reply.=0A=
=0A=
Viraj =0A=
________________________________________=0A=
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>=0A=
Sent: Thursday, October 26, 2017 4:13 AM=0A=
To: Raiyani, Viraj; bridge@lists.linux-foundation.org=0A=
Subject: Re: [Bridge] Linux Bridge Static FDB move=0A=
=0A=
On 2017/10/26 1:47, Viraj.Raiyani@dell.com wrote:=0A=
> Hi Everyone,=0A=
>=0A=
>=0A=
> Is it possible to program the FDB entry in Linux Bridge which is static,=
=0A=
> non-local and doesn't move to new interface when the same source MAC=0A=
> packet comes on a different interface in the same bridge  ?=0A=
=0A=
AFAIK no.=0A=
Bridge supports static fdb entries, but br_fdb_update() updates their=0A=
dst even for static entries.=0A=
=0A=
>=0A=
>=0A=
> I tried programming the MAC as permanent that prevents the moving of MAC=
=0A=
> to a new interface in the same bridge, however it treats the MAC as=0A=
> local and doesn't do the forwarding ?=0A=
=0A=
Yes, local entries will deliver frames to the bridge device itself.=0A=
=0A=
--=0A=
Toshiaki Makita=0A=
=0A=
