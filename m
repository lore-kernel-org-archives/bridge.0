MIME-Version: 1.0
From: Benjamin Vanheuverzwijn <bvanheu@gmail.com>
Date: Sat, 27 Nov 2010 16:46:34 -0500
Message-ID: <AANLkTikviZkym71gVp6BZUeiqHjbARhjB-J-mnE_5A6J@mail.gmail.com>
Content-Type: multipart/alternative; boundary=000325573fb20aeb1b04960fc788
Subject: [Bridge] Disable mac address learning
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--000325573fb20aeb1b04960fc788
Content-Type: text/plain; charset=UTF-8

Hi,

Is there a way to disable the mac address learning in linux using "brctl" or
custom code so any packet sent to the bridge will be flooded in each
interfaces.

I would like to do something similar as OpenBSD:
$ brconfig <bridge> -learn <iface>
$ man brconfig
...
     -learn interface
             Mark interface so that the source address of packets received
             from interface are not entered into the address cache.
...

I tried to search on google and on the mailing-list without success.

Thanks in advance for your replies,

-- 
Benjamin Vanheuverzwijn

Google Talk/Jabber - bvanheu@gmail.com
http://vanheu.ca

--000325573fb20aeb1b04960fc788
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>Is there a way to disable the mac address learning i=
n linux using &quot;brctl&quot; or custom code so any packet sent to the br=
idge will be flooded in each interfaces.</div><div><br></div><div>I would l=
ike to do something similar as OpenBSD:</div>

<div>$ brconfig &lt;bridge&gt; -learn &lt;iface&gt;</div><div>$ man brconfi=
g</div><div>...</div><div><div>=C2=A0=C2=A0 =C2=A0 -learn interface</div><d=
iv>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark interface so that t=
he source address of packets received</div><div>

=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from interface are not ente=
red into the address cache.</div></div><div>...</div><div><br></div><div>I =
tried to search on google and on the mailing-list without success.</div><di=
v><br></div><div>Thanks in advance for your replies,<br clear=3D"all">

<br>-- <br>Benjamin Vanheuverzwijn<br><br>Google Talk/Jabber - <a href=3D"m=
ailto:bvanheu@gmail.com">bvanheu@gmail.com</a><br><a href=3D"http://vanheu.=
ca">http://vanheu.ca</a><br><br>
</div>

--000325573fb20aeb1b04960fc788--
