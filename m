Message-ID: <dbf855d00512302312n6029bd75i3690666c77e26f06@mail.gmail.com>
Date: Fri, 30 Dec 2005 23:12:54 -0800
From: <wandering.womble@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] definite bridging bug in sis 900 driver for kernel 2.6.14
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi there-
continuing the saga of kernel panics, I threw a spare pci ethernet
card ('tulip' driver), and can now successfully add the new eth1 to a
bridge, and so far it hasn't taken out the kernel ;-).

This is on the same kernel & module compile, so I don't think I have a
build problem with the sis 900 module as someone suggested.

So it looks like the sis 900 kernel module is broken for bridging.  If
anyone is willing to take a look at this, I'm happy to try patches and
re-test.

Regards

Julian
