Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 2 Jul 2004 12:17:15 -0500
Message-ID: <D1BBAADDE65D9646B5F0C6332C038B4E06F13A@mbgexc.mbgdocs.com>
From: "Bert Hubbs" <bhubbs@mbgdocs.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridge support unavailable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

When I start Linux I get an error:

"Bridge support unavailable: brctl not found". 

And then eth0 - 2 load with no problems. After system is up I can build
the bridge but it does not survive a reboot. Do I need a startup script
or should it build from the:

/etc/init.d/bridge
/etc/sysconfig/network-scripts/ifcfg-bro
/etc/sysconfig/network-scripts/ifcfg-eth0
/etc/sysconfig/network-scripts/ifcfg-eth1
/etc/sysconfig/network-scripts/ifcfg-eth2



I am using Core2 



Bert Hubbs
McGlinchey Stafford and
Youngblood & Bendalin, PLLC
2711 N. Haskell Ave.
Suite 2700, LB 25
Dallas, TX 75204
214-257-1817 (direct dial)
469-235-1817 (mobile)
214-257-1881 (fax)



The information contained in this e-mail message is intended only for the personal and confidential use of the recipient(s) named above. This message may be an attorney-client communication and/or work product and as such is privileged and confidential. If the reader of this message is not the intended recipient or an agent responsible for delivering it to the intended recipient, you are hereby notified that you have received this document in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify us immediately by e-mail, and delete the original message. 

