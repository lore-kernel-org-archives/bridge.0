Message-ID: <49002b820611170149n645e35e6n76edc98fe6c9596@mail.gmail.com>
Date: Fri, 17 Nov 2006 17:49:02 +0800
From: "d tbsky" <tbskyd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14156_8283905.1163756942797"
Subject: [Bridge] bridge physical to several dummy interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_14156_8283905.1163756942797
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:
    i want to bridge my eth0 interface to several dummy interface, like
vmware or xen did,
so i can request several dhcp ip address via several mac addresses.
   but i am stuck in the first step:
   assume my eth0 is 192.168.10.1, and it can ping 192.168.10.254.
    ifconfig br0 up
    brctl setfd br0 0
    brctl addif br0 eth0

    now i can not ping 192.168.10.254 anymore.
    but if i set 192.168.10.2 to br0, i can ping 192.168.10.254.
    and "dhclient eth0" can get ip addess from dhcp server(that surprise
me!!)
    i try to add dummy interface to br0, but dummy interface can not work,
like eth0.
    "brctl showmac br0" give me may mac addresses, so i think bridging is
working.

    i think i must misunderstanding the brindge concept.
    can i keep eth0 work after it join br0?
    thanks a lot for your help!!

Regards,
tbsky

------=_Part_14156_8283905.1163756942797
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:<br>&nbsp;&nbsp;&nbsp; i want to bridge my eth0 interface to several dummy interface, like vmware or xen did,<br>so i can request several dhcp ip address via several mac addresses.<br>&nbsp;&nbsp; but i am stuck in the first step:<br>&nbsp;&nbsp; assume my eth0 is 
<a href="http://192.168.10.1">192.168.10.1</a>, and it can ping <a href="http://192.168.10.254">192.168.10.254</a>.<br>&nbsp;&nbsp;&nbsp; ifconfig br0 up<br>&nbsp;&nbsp;&nbsp; brctl setfd br0 0<br>&nbsp;&nbsp;&nbsp; brctl addif br0 eth0<br><br>&nbsp;&nbsp;&nbsp; now i can not ping 
<a href="http://192.168.10.254">192.168.10.254</a> anymore.&nbsp; <br>&nbsp;&nbsp;&nbsp; but if i set <a href="http://192.168.10.2">192.168.10.2</a> to br0, i can ping <a href="http://192.168.10.254">192.168.10.254</a>.<br>&nbsp;&nbsp;&nbsp; and &quot;dhclient eth0&quot; can get ip addess from dhcp server(that surprise me!!)
<br>&nbsp;&nbsp;&nbsp; i try to add dummy interface to br0, but dummy interface can not work, like eth0.<br>&nbsp;&nbsp;&nbsp; &quot;brctl showmac br0&quot; give me may mac addresses, so i think bridging is working.<br><br>&nbsp;&nbsp;&nbsp; i think i must misunderstanding the brindge concept.
<br>&nbsp;&nbsp;&nbsp; can i keep eth0 work after it join br0?<br>&nbsp;&nbsp;&nbsp; thanks a lot for your help!!<br><br>Regards,<br>tbsky<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; <br>

------=_Part_14156_8283905.1163756942797--
