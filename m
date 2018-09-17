Return-Path: <mchehab@bombadil.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=Sender:Message-Id:Date:Subject:Cc:To:
	From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/cb3JVdZScPLfe5FtiUJes+H+FOyYdzKv8NGg0tmrEw=;
	b=XXcQd0r5jZBqwtDwSptR4bHjMZ
	PL3ywpw1mLxJfMNxSHxSOabRGbcllECL8lOWAMh08i/qZRE41QDWTORkO16sPGy9UA9uxH7M8lce6
	Jt9MtqkePLMB11Giojl1fTmGL1mbJUJHZr5bpzlxQkUoowU/33SKxa4JPXiE/brNcKEzMMNvq0Nn7
	GWMACUHCa4ZUjHqtpOSIZXp30hnlZSm98+eNTxyRPRjRp5my2NdhkKHvq6AOnZ5jLnrkodeTYL+TB
	WHmVthkjWLb+0vM+i0RjXYLgagar33hcFTuWCZfV9ROaXUh+UUDrRnZ+yMT72H1kM0PWEDDGxG1k7
	Z4JN3DTw==;
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Mon, 17 Sep 2018 15:02:34 -0400
Message-Id: <6b47bf56b898c48a0dc3cd42283c9e5c7c23367a.1537210894.git.mchehab+samsung@kernel.org>
Sender: Mauro Carvalho Chehab <mchehab@bombadil.infradead.org>
Subject: [Bridge] [PATCH] docs: fix some broken documentation references
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, netdev@vger.kernel.org, Jan Kara <jack@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Linux Media Mailing List <linux-media@vger.kernel.org>

Some documentation files received recent changes and are
pointing to wrong places.

Those references can easily fixed with the help of a
script:

	$ ./scripts/documentation-file-ref-check --fix

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/filesystems/dax.txt  | 2 +-
 Documentation/filesystems/ext2.txt | 2 +-
 MAINTAINERS                        | 4 ++--
 net/bridge/Kconfig                 | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index 70cb68bed2e8..bc393e0a22b8 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -75,7 +75,7 @@ exposure of uninitialized data through mmap.
 
 These filesystems may be used for inspiration:
 - ext2: see Documentation/filesystems/ext2.txt
-- ext4: see Documentation/filesystems/ext4.txt
+- ext4: see Documentation/filesystems/ext4/ext4.rst
 - xfs:  see Documentation/filesystems/xfs.txt
 
 
diff --git a/Documentation/filesystems/ext2.txt b/Documentation/filesystems/ext2.txt
index 81c0becab225..a45c9fc0747b 100644
--- a/Documentation/filesystems/ext2.txt
+++ b/Documentation/filesystems/ext2.txt
@@ -358,7 +358,7 @@ and are copied into the filesystem.  If a transaction is incomplete at
 the time of the crash, then there is no guarantee of consistency for
 the blocks in that transaction so they are discarded (which means any
 filesystem changes they represent are also lost).
-Check Documentation/filesystems/ext4.txt if you want to read more about
+Check Documentation/filesystems/ext4/ext4.rst if you want to read more about
 ext4 and journaling.
 
 References
diff --git a/MAINTAINERS b/MAINTAINERS
index 9989925f658d..078a4cf6d064 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -840,7 +840,7 @@ ANALOG DEVICES INC ADGS1408 DRIVER
 M:	Mircea Caprioru <mircea.caprioru@analog.com>
 S:	Supported
 F:	drivers/mux/adgs1408.c
-F:	Documentation/devicetree/bindings/mux/adgs1408.txt
+F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
 
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
@@ -5515,7 +5515,7 @@ W:	http://ext4.wiki.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 S:	Maintained
-F:	Documentation/filesystems/ext4.txt
+F:	Documentation/filesystems/ext4/ext4.rst
 F:	fs/ext4/
 
 Extended Verification Module (EVM)
diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index aa0d3b2f1bb7..3625d6ade45c 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -17,7 +17,7 @@ config BRIDGE
 	  other third party bridge products.
 
 	  In order to use the Ethernet bridge, you'll need the bridge
-	  configuration tools; see <file:Documentation/networking/bridge.txt>
+	  configuration tools; see <file:Documentation/networking/bridge.rst>
 	  for location. Please read the Bridge mini-HOWTO for more
 	  information.
 
-- 
2.17.1

