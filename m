Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bae22be11b2e93ffe2c4c4cc5e25d9a3@shee.org>
Content-Transfer-Encoding: 7bit
From: Moire <sec@shee.org>
Date: Tue, 12 Dec 2006 16:17:46 +0100
Subject: [Bridge] Dead loop: "bridge ended up including itself"
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hello List,

some time ago i already asked this, in the meanwhile i did
not found a solution nor i have any idea why this happens.

Scenario:

Every now and then i get this urgent warning:

1 Time(s): Dead loop on virtual device br0, fix it urgently!

Stephen Hemminger wrote (16.08.2006 20:09) this:
> It looks like a bridge ended up including itself some how.

Its for me unclear when this happens and what trigger this.

I would appreciate any info to some resources. For example
a technical document covering this issue or similar.

My setup is a kernel 2.4.31 with bridge-utils 1.0.4. The box
have three network interfaces eth[0-2]. Bridged interfaces
are eth[1-2] (router,dmz), eth0 is my intranet.
I use DLINK network cards with sk98lin driver.


Many thanks in advance.

Best regards

C. Moire


