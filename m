Date: Mon, 27 Nov 2006 13:31:03 +0100
From: Lutz Jaenicke <ljaenicke@innominate.com>
Message-ID: <20061127123102.GA15052@innominate.com>
References: <20061126060423.50525.qmail@web54212.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20061126060423.50525.qmail@web54212.mail.yahoo.com>
Subject: Re: [Bridge] Passing vlan tagged packets through linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Sat, Nov 25, 2006 at 10:04:23PM -0800, kasra kangavari wrote:
> Dear Roman
> =20
>  If I don't use trunk over linux bridges(packets without vlan tag) then I=
 can ping more than 1500bytes(MTU).the problem is vlan tagged packets. r u =
sure about jumbo frames that solve this problem ?

Did you have a look at the MTUs of the interfaces? If you need to
support VLAN tagged frames, at least the physical interfaces
need to accept frames with additional 4 bytes on the wire.
If this is not handled in the driver the 1500+ETH+VLAN-frames will
already be dropped (not even be received) at the physical interfaces.
You may have to allow an MTU of 1504 for this reason.

Regards,
	Lutz
--=20
Dr.-Ing. Lutz J=E4nicke
CTO
Innominate Security Technologies AG  /protecting industrial networks/
tel: +49.30.6392-3308
fax: +49.30.6392-3307
Albert-Einstein-Str. 14
D-12489 Berlin, Germany
www.innominate.com
---------------------------------------------------------------

Visit us at the SPS/IPC/Drives in Nuernberg

28 - 30 November 2006, Hall 9, Stand 9-125

---------------------------------------------------------------
