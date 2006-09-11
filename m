From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: 12 Sep 2006 00:04:15 +0200
Message-ID: <m3ac56vz4w.fsf@ursa.amorsen.dk>
References: <20060911174928.GA3451@devicescape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: Re: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

>>>>> "DK" == David Kimdon <david.kimdon@devicescape.com> writes:

DK> Hi, The attached patches enables the bridge to filter and forward
DK> packets according to their IEEE 802.1q headers.

How does this work in the presence of hardware VLAN acceleration (as
almost all important cards/drivers offer)? In that case it seems that
the tag is stripped and forgotten about. Does this code somehow avoid
the problem?


/Benny



