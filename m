Date: Tue, 25 Aug 2009 08:47:30 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090825084730.0f8d50df@nehalam>
In-Reply-To: <f05d3b1c0908250051p29b1c440mfd0e90bf31679249@mail.gmail.com>
References: <f05d3b1c0908250051p29b1c440mfd0e90bf31679249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge through code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: LucaMt <lucamt74@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 25 Aug 2009 09:51:50 +0200
LucaMt <lucamt74@gmail.com> wrote:

> Hi,
> I want to ask if exist a way allowing bridge control through c/c++ code.
> Where I can found API to develop an user interface to manage the bridge.
> 
> Thanks
> 
> Best regards
> 
> Luca

Look at existing bridge utilities (brctl) and RSTP source code.

       git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
       git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git
-- 
