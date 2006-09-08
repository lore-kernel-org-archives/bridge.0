Message-ID: <82b0add70609081551m63a2264rbc79e9ea0b2c055c@mail.gmail.com>
Date: Fri, 8 Sep 2006 18:51:18 -0400
From: "Joubert Berger" <joubertb@gmail.com>
Sender: joubert@berger-family.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] skb timestamp set in bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

In 2.4, I relied on the skb->stamp to contain the timestamp of when
the packet entered the bridge.  In 2.6, I don't seem to be seeing this
behaviour.  Is this correct?  If so, what is the best place for me to
grab the timestamp of the packet entering the bridge.

TIA.

--joubert
