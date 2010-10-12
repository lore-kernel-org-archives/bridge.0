Date: Tue, 12 Oct 2010 10:10:51 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101012101051.43dfd499@nehalam>
In-Reply-To: <AANLkTin=6Uf_fwGWJ9Q6CQct1cARtHWHJ0geNRz0JDed@mail.gmail.com>
References: <AANLkTin=6Uf_fwGWJ9Q6CQct1cARtHWHJ0geNRz0JDed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Real time issues when using a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 12 Oct 2010 16:31:36 +0200
Jean-Michel Hautbois <jhautbois@gmail.com> wrote:

> Hi there !
>=20
> I am facing a jitter issue that I will try to explain :
> I have the following configuration :
>=20
> (A) eth0 <--> br0 <--> eth1 (B)
>=20
> I have a small and custom kernel (I removed netfilter, for instance) and I
> am measuring the time between A and B (using hardware taps, etc.).
> My bandwidth is quite small (each packet is about 200 bytes and there is a
> delay of 10ms between each packet).
> I am measuring both the latency and the jitter (max_latency - min_latency)
> and this one is quite large.
>=20
> I added ftrace option, and after some (long) investigations, I am current=
ly
> limiting my study to the bridge part.
>=20
> When I trace only br_handle_frame and br_forward_finish and do my test on
> 6500 frames I have :
> - average latency of 39=B5s
> - minimum latency of 34 =B5s
> - maximum latency of 81=B5s
>=20
> Thus, my jitter is 47=B5s.
> This may seem low, but this is about two to three times what I expect and=
 I
> cannot see why a bridge which is only forwarding a frame would have jitte=
r ?
> If you have any idea, everything is interesting for me.
> I thought maybe to skb_clone ?
>=20
> Best Regards,
> JM

You probably have NAPI and/or interrupt coalescing setting
enabled on one or both of the devices.

--=20
