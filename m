Date: Mon, 20 Oct 2003 16:07:12 +0200
From: Christian Schroeder <christian.schroeder@imms.de>
Message-ID: <1066658832.3f93ec10cdf08@memphis.imms.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] rapid spanning tree 
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi list,

I'm very new to this list, but we have the task to realize a linux
based bridging device with fast loop detection support. We want to
built an embedded linux device ( arm7 or arm9 based) with 3 ethernet
interfaces. As I understood, the linux bridging code contains already
stp (802.1d) support. So we could try to use this and to play with the
stp timing constants, but I think, it would be much better to implement
the 802.1w extensions in the bridging code. Are there any hints re-
garding this subject and is there any detailed documentation about
the linux bridging code (besides the source code itself) or is there
already a project running to implement 802.1w for a recent linux kernel?

thanks a lot and best regards
Christian Schroeder

Dr.-Ing. Christian Schroeder
Institut fuer Mikroelektronik- und Mechatronik-Systeme
Langewiesener Strasse 22
98693 Ilmenau
Telefon: +49 3677 678315
Telefax: +49 3677 678337
Mobil:   +49 173 5789172
e-mail:  christian.schroeder@imms.de
e-mail:  christian.schroeder.ik@gmx.de

