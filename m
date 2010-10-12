MIME-Version: 1.0
Date: Tue, 12 Oct 2010 16:31:36 +0200
Message-ID: <AANLkTin=6Uf_fwGWJ9Q6CQct1cARtHWHJ0geNRz0JDed@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: multipart/alternative; boundary=0016e65b5820914dfc04926c55b4
Subject: [Bridge] Real time issues when using a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016e65b5820914dfc04926c55b4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi there !

I am facing a jitter issue that I will try to explain :
I have the following configuration :

(A) eth0 <--> br0 <--> eth1 (B)

I have a small and custom kernel (I removed netfilter, for instance) and I
am measuring the time between A and B (using hardware taps, etc.).
My bandwidth is quite small (each packet is about 200 bytes and there is a
delay of 10ms between each packet).
I am measuring both the latency and the jitter (max_latency - min_latency)
and this one is quite large.

I added ftrace option, and after some (long) investigations, I am currently
limiting my study to the bridge part.

When I trace only br_handle_frame and br_forward_finish and do my test on
6500 frames I have :
- average latency of 39=C2=B5s
- minimum latency of 34 =C2=B5s
- maximum latency of 81=C2=B5s

Thus, my jitter is 47=C2=B5s.
This may seem low, but this is about two to three times what I expect and I
cannot see why a bridge which is only forwarding a frame would have jitter =
?
If you have any idea, everything is interesting for me.
I thought maybe to skb_clone ?

Best Regards,
JM

--0016e65b5820914dfc04926c55b4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi there !<br><br>I am facing a jitter issue that I will try to explain :<b=
r>I have the following configuration :<br><br>(A) eth0 &lt;--&gt; br0 &lt;-=
-&gt; eth1 (B)<br><br>I have a small and custom kernel (I removed netfilter=
, for instance) and I am measuring the time between A and B (using hardware=
 taps, etc.).<br>
My bandwidth is quite small (each packet is about 200 bytes and there is a =
delay of 10ms between each packet).<br>I am measuring both the latency and =
the jitter (max_latency - min_latency) and this one is quite large.<br>
<br>I added ftrace option, and after some (long) investigations, I am curre=
ntly limiting my study to the bridge part.<br><br>When I trace only br_hand=
le_frame and br_forward_finish and do my test on 6500 frames I have :<br>
- average latency of 39=C2=B5s<br>- minimum latency of 34 =C2=B5s<br>- maxi=
mum latency of 81=C2=B5s<br><br>Thus, my jitter is 47=C2=B5s.<br>This may s=
eem low, but this is about two to three times what I expect and I cannot se=
e why a bridge which is only forwarding a frame would have jitter ?<br>
If you have any idea, everything is interesting for me.<br>I thought maybe =
to skb_clone ?<br><br>Best Regards,<br>JM<br><br>

--0016e65b5820914dfc04926c55b4--
