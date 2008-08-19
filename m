Message-ID: <442a305e0808182232r4591c018v1b33b3100d725ac@mail.gmail.com>
Date: Tue, 19 Aug 2008 01:32:22 -0400
From: "joy c" <cjjoy1980@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3727_26754657.1219123942859"
Subject: [Bridge] linux bridging problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_3727_26754657.1219123942859
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
  I am trying to creat a bridge with the following command:
        brctl addbr br0
        brctl addif br0 eth0
        brctl addif br0 pci0
        ifconfig eth0 up
        ifconfig pci0 up
        ifconfig br0 up
        dhclient br0

I am able to see the bridge and interfaces to the bridge using brctl show
command.. But when I run the
dhclient br0 command, the system stops responding.  I am not able to see
anything on the termnial and the termnial does not respond...  Please let me
what is the problem....

Thanks,
joy

------=_Part_3727_26754657.1219123942859
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><p>Hi,<br>&nbsp; I am trying to creat a bridge with the following command:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl addbr br0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl addif br0 eth0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl addif br0 pci0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifconfig eth0 up<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifconfig pci0 up<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifconfig br0 up<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dhclient br0</p>
<p>I am able to see the bridge and interfaces to the bridge using brctl show command.. But when I run the<br>dhclient br0 command, the system stops responding.&nbsp; I am not able to see anything on the termnial and the termnial does not respond...&nbsp; Please let me what is the problem....</p>

<p>Thanks,<br>joy</p></div>

------=_Part_3727_26754657.1219123942859--
