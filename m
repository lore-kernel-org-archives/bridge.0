Date: Thu, 21 Apr 2005 14:16:43 +1000
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] stp port state always remains forwarding ...
Message-ID: <20050421141643.7a23865c@localhost.localdomain>
In-Reply-To: <20050420080923.26103.qmail@webmail9.rediffmail.com>
References: <20050420080923.26103.qmail@webmail9.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: ashish anand <ashish_ibm@rediffmail.com>
Cc: bridge@lists.osdl.org

On 20 Apr 2005 08:09:23 -0000
"ashish  anand" <ashish_ibm@rediffmail.com> wrote:

> if I just connect two similar port say both 10 gb of one switch to anothe=
r symmetric bridge with stp enabled on both bridge  , stpstate of all four =
ports always remain forwarding.

Is STP enabled? It is off by default now.

> ( may be because all four of them are either root or desginated port in a=
bove setup)
>=20
> should I except that one port atleast will get into blocking state , if i=
 connect two non-similar ports together say a 10gb port on one switch to FE=
 port on another switch as now path-cost to root will differ. ( as path-cos=
t depending on link speed )=A0
>

If STP is working, it should see the loop and take one port out of forwardi=
ng.

> Best Regards,
> Ashish Anand

