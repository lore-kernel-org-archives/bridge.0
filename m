Date: Sat, 15 Mar 2008 04:50:39 -0700 (PDT)
From: Scott MacKay <scottmackay@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <941215.43035.qm@web52404.mail.re2.yahoo.com>
Subject: [Bridge] catching all packets on an interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linux-foundation.org

In a simple bridge design, eth0, eth1, bridged to br0,
what iptables rules would be needed to capture all of
the packets?

It looked like one in PREROUTING/mangle and
POSTROUTING/mangle would do it for all locally
delivered/received and passthru....

-Scott


      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
