Date: Wed, 25 Feb 2009 11:45:42 +0100
From: Boris Dores <babal@via.ecp.fr>
Message-ID: <20090225104542.GR30489@via.ecp.fr>
References: <20090224023129.GA17642@hedwig.net.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20090224023129.GA17642@hedwig.net.cmu.edu>
Subject: Re: [Bridge] PVSTP+ support ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "L. Gabriel Somlo" <gsomlo@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, Feb 23, 2009 at 09:31:31PM (GMT-0500), L. Gabriel Somlo wrote:
> If not, any other ideas on how to accomplish redundancy would be much
> appreciated.

  IMHO you could do routing (+VRRP) directly on the linux boxes. The
exact setup however (interfaces, VLANs, Hops, ...) obviously depends on
your other constraints.

--=20
Boris Dor=E8s
