Message-ID: <971341.46520.qm@web65703.mail.ac4.yahoo.com>
Date: Sun, 30 Aug 2009 02:33:27 -0700 (PDT)
From: "salaria113@yahoo.com" <salaria113@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1798065071-1251624807=:46520"
Subject: [Bridge] bridge management through code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

--0-1798065071-1251624807=:46520
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=0AI need to create an user interface (QT based MMI) to manage bridge bu=
t I can't found c/c++ function in user space to develop this application.=
=0AThe functions are: br_add_bridge, br_del_bridge etc. in libbridge.a libr=
ary are accessible from user space linking the library ?=0AThese functions =
are in=0Auser space or kernel space ? =0ADeveloping an application (bridgeC=
onf.so)=0Aduring loading phase of the application the undefined reference e=
rror=0Arelated to the previus functions is generated.=0AWhile if I try to u=
se thase functions in kernel space a compile time error is generated, the f=
unction are not declared.=0AAre the br_*_bridge functions the correct way t=
o manage bridge through code in user space ?=0AFor our needs something in k=
ernel space is useful too. What you can suggest ?=0A=0AThanks=0A=0ABest Reg=
ards=0A=0ALuca=0A=0A=0A      
--0-1798065071-1251624807=:46520
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>Hi,<br>I need to create an user interface (QT based MMI) =
to manage bridge but I can't found c/c++ function in user space to develop =
this application.<br>The functions are: br_add_bridge, br_del_bridge etc. i=
n libbridge.a library are accessible from user space linking the library ?<=
br>These functions are in=0Auser space or kernel space ? <br>Developing an =
application (bridgeConf.so)=0Aduring loading phase of the application the u=
ndefined reference error=0Arelated to the previus functions is generated.<b=
r>=0AWhile if I try to use thase functions in kernel space a compile time e=
rror is generated, the function are not declared.<br>Are the br_*_bridge fu=
nctions the correct way to manage bridge through code in user space ?<br>Fo=
r our needs something in kernel space is useful too. What you can suggest ?=
<br><br>Thanks<br>=0A=0A=0A<br>Best Regards<br><br>Luca</div></div><br>=0A=
=0A=0A=0A      </body></html>
--0-1798065071-1251624807=:46520--
