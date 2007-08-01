Date: Wed, 1 Aug 2007 16:48:10 +0100
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Jumbo frames support?
Message-ID: <20070801164810.0798ccfe@oldman.hamilton.local>
In-Reply-To: <64C75177-A0E0-450C-80EB-63B7F46E1CBA@lesinigo.it>
References: <64C75177-A0E0-450C-80EB-63B7F46E1CBA@lesinigo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Luca Lesinigo <luca@lesinigo.it>
Cc: bridge@lists.linux-foundation.org

On Wed, 1 Aug 2007 14:09:45 +0200
Luca Lesinigo <luca@lesinigo.it> wrote:

> The documentation says the bridge will work as far as all interfaces  
> have the same MTU, but I also read on this and other mailing lists  
> people having problems when using jumbo frames.
> 
> What is the current status of jumbo frames support in the bridge?
> It could also be useful to have the same info on the wiki page.
> 
> Thanks.
> 
> --
> Luca Lesinigo
> 
> 

Bridge ignores frame size. The devices have to have same MTU
to work. 
