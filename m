Date: Wed, 5 May 2004 17:14:44 -0400
From: Ali Bahar <alih@internetDog.org>
Subject: Re: [Bridge] Spanning Tree Source Code
Message-ID: <20040505211444.GA7568@internetDog.org>
References: <200405051729.10511.fmtrindade@inf.ufrgs.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405051729.10511.fmtrindade@inf.ufrgs.br>
Reply-To: alih@internetDog.org
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge List <bridge@lists.osdl.org>

On Wed, May 05, 2004 at 05:29:10PM -0300, Francisco Maestri Trindade wrote:
> 
>  Hi ,
> 
>  Im new in this list, and Im trying to find a Spanning Tree source code, the 
> kind that runs in bridges and switches.
>  Does anybody know wher I can find it? Any help would be appreciated.

Recent Linux kernels have this incorporated. Eg in 2.4.20 you'll find
it in ./net/bridge/br_stp.c .
It's GPLed, of course.

later,
ali
-- 
                     Single State Solution
     Israeli Citizenship & Democratic Rights For All in Gaza & West Bank
