MIME-Version: 1.0
Date: Wed, 7 Oct 2009 13:22:44 -0700
Message-ID: <88ed5400910071322l360fe50cn2986895549f60f82@mail.gmail.com>
From: NITIN SS <hi.nitin2000@gmail.com>
Content-Type: multipart/alternative; boundary=0016e64ec0a20d410b04755e1ca9
Subject: [Bridge] Distributed RSTP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016e64ec0a20d410b04755e1ca9
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am new to this RSTP/Bridge group and currently planning on distributed
RSTP.

First of all, Distributed RSTP mean as, we will have 8 linux RSTPs and they
all will have the same Bridge ID.
As all bridges will have the same Bridge ID so I need to sync many variables
functions across all units.
Additionally there should be only one root port for all the eight bridges.
In this way there should be one master which would be maintaing bridge
variables and controlling bridge operations.
There is only point to point link between all bridges through master.
Additioanlly most of the RSTP state machines are port based so it looks
feasible.

As your guys are RSTP experts, so i think it would be the right place to get
suggestions/comments.

-What would be the limitations/complex Issues?
-Is it feasible?
 At top level it looks like there would be lot of efforts with respect to
final outcome.
-Is there any implementation of distributed RSTP?

Appreciate your comments.

Regards,
Nitin

--0016e64ec0a20d410b04755e1ca9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>I am new to this RSTP/Bridge group and currently planning on distribut=
ed RSTP.</div>
<div>=A0</div>
<div>First of all, Distributed RSTP mean as, we will have=A08 linux RSTPs a=
nd they all will=A0have the same Bridge ID.</div>
<div>As all bridges will have the same Bridge ID so I need to sync many var=
iables functions across all units.</div>
<div>Additionally there should be only one root port for all the=A0eight br=
idges.</div>
<div>In this way there should be one master which would be maintaing bridge=
 variables and controlling bridge operations.</div>
<div>There is only point to point link between all bridges through master.<=
/div>
<div>Additioanlly most of the RSTP state machines are port based so it look=
s feasible.</div>
<div>=A0</div>
<div>As your guys are RSTP experts, so i think it would be the right place =
to get suggestions/comments.</div>
<div>=A0</div>
<div>-What would be the limitations/complex Issues?</div>
<div>-Is it feasible? </div>
<div>=A0At top level it looks like=A0there would be lot of efforts with res=
pect to final outcome.</div>
<div>-Is there any implementation of distributed RSTP? </div>
<div>=A0</div>
<div>Appreciate your comments.</div>
<div>=A0</div>
<div>Regards,</div>
<div>Nitin</div>

--0016e64ec0a20d410b04755e1ca9--
