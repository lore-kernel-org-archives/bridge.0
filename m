From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 27 Mar 2011 08:27:22 +0200
Message-Id: <1301207244-10428-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <20110327034404.GC31916@Sellars>
References: <20110327034404.GC31916@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] bridge: mcast snooping, fixes for IPv6 MLDv1/2 parsing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, Herbert Xu <herbert@gondor.hengli.com.au>, David Miller <davem@davemloft.net>, netdev@vger.kernel.org

Hi everyone,

The following two patches are fixing two issues, related to the parsing of
IPv6 MLD messages.

The first one fixes an observed issue which lead to ignored MLD messages.
In the tests this patch fixes the issue in my scenario. However I'm not
so familiar with the checksumming functions in the kernel, so would be
great if someone could double-check whether the new checksum calculations
make sense like this.

The second patch fixes a potential issue. Bogus values of the 'len' variable
had been observed during tests and this patch successfully fixed this
here. However this patch is untested for the potential issues named
in the patch's description that could have occured without it.

Both patches together have been applied and tested and no more
issues with the parsing and adding of new IPv6 multicast listeners to
the bridge snooping database could be observed (for now ;) ).

Cheers, Linus
