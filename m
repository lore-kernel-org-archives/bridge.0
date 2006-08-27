Message-ID: <82b0add70608270705t7dc2bb67h108317b34cdc12f3@mail.gmail.com>
Date: Sun, 27 Aug 2006 10:05:01 -0400
From: "Joubert Berger" <joubertb@gmail.com>
Sender: joubert@berger-family.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] SMP vs UNP performance
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I was running a frame loss test the other day against an rhel4 smp
kernel and a non-smp kernel.  I noticed I was getting better numbers
when I ran the non-smp kernel.  I was surprised by that.  Anyone have
any insight into this?  I am running this with e1000 dirvers.

I also ran a test where I ran the smp kernel with hyper threading
turned on and off.  There, the frame loss numbers were worse when
hyper threading was turned off.  I would not have thought that having
hyperthreading turned off would make such a big difference.

Just trying to make sense of these numbers :-)

--joubert
